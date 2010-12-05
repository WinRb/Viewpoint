#############################################################################
# Copyright © 2010 Dan Wanek <dan.wanek@gmail.com>
#
#
# This file is part of Viewpoint.
# 
# Viewpoint is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
# 
# Viewpoint is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
# 
# You should have received a copy of the GNU General Public License along
# with Viewpoint.  If not, see <http://www.gnu.org/licenses/>.
#############################################################################


# This class is inherited by all Item subtypes such as Message, Event,
# and Task.  It will serve as the brain for all of the methods that
# each of these Item types have in common.
module Viewpoint
  module EWS
    class Item
      include Model

      # This is a class method that fetches an existing Item from the
      #  Exchange Store.
      # @param [String] item_id The id of the item.
      # @return [Item] Returns an Item or subclass of Item
      # @todo Add support to fetch an item with a ChangeKey
      def self.get_item(item_id)
        conn = Viewpoint::EWS::EWS.instance
        resp = conn.ews.get_item([item_id])
        resp = resp.items.shift
        resp_type = resp.keys.first
        eval "#{resp_type.to_s.camel_case}.new(resp[resp_type])"
      end

      # Add attachments to the passed in ParentId
      # @param [String,Hash] parent_id Either a String ItemId or a Hash ItemId with a ChangeKey
      # @option parent_id [String] :id The Id
      # @option parent_id [String] :change_key The ChangeKey
      # @param [Array<File>] attachments An Array of File objects to read in.
      def self.add_attachments(parent_id, attachments)
        conn = Viewpoint::EWS::EWS.instance
        b64attach = []
        attachments.each do |a|
          b64attach << {:name => {:text =>(File.basename a.path)}, :content => {:text => Base64.encode64(a.read)}}
        end
        resp = conn.ews.create_attachment(parent_id, b64attach) 
        (resp.status == 'Success') || (raise EwsError, "Could not create attachments. #{resp.code}: #{resp.message}")
        {:id => resp.items.first[:attachment_id][:root_item_id], :change_key => resp.items.first[:attachment_id][:root_item_change_key]}
      end

      attr_reader :item_id, :change_key
      alias :id :item_id

      # Initialize an Exchange Web Services item
      # @param [Hash] ews_item A hash representing this item
      # @param [Boolean] shallow Whether or not we have retrieved all the elements for this object
      def initialize(ews_item, shallow = true)
        super() # Calls initialize in Model (creates @ews_methods Array)
        @ews_item = ews_item
        @shallow = shallow
        @item_id = ews_item[:item_id][:id]
        @change_key = ews_item[:item_id][:change_key]
        @text_only = false

        init_methods
      end


      # See if this item is set to return only text in its body.
      # @return [Boolean] if true the body will return only text, otherwise it may be HTML or text.
      def text_only?
        @text_only
      end

      # Set whether or not the body should be text-only or not
      # @param [Boolean] txt if true the body will return only text, otherwise it may be HTML or text.
      def text_only=(txt)
        @text_only = ( txt == true ? true : false)
      end

      # Call UpdateItem for this item with the passed updates
      # @param [Hash] updates a well-formed update hash
      # @example {:set_item_field=>{:field_u_r_i=>{:field_u_r_i=>"message:IsRead"}, :message=>{:is_read=>{:text=>"true"}}}}
      def update!(updates)
        conn = Viewpoint::EWS::EWS.instance
        resp = conn.ews.update_item([{:id => @item_id, :change_key => @change_key}], {:updates => updates})
        (resp.status == 'Success') || (raise EwsError, "Trouble updating Item. #{resp.code}: #{resp.message}")
      end

      # This takes a hash of attributes with new values and builds the appropriate udpate hash
      # @param [Hash] updates a hash that is formed like so :item_attr => newvalue
      # @example  {:sensitivity => {:text => 'Normal'}, :display_name => {:text => 'Test User'}}
      def update_attribs!(updates)
        changes = []
        type = self.class.name.split(/::/).last.ruby_case.to_sym

        updates.each_pair do |k,v|
          changes << {:set_item_field=>{:field_u_r_i=>{:field_u_r_i=>FIELD_URIS[k]}, type=>{k => v}}}
        end

        update!(changes)
      end

      # Mark this Item as read
      def mark_read!
        field = :is_read
        update!({:set_item_field=>{:field_u_r_i=>{:field_u_r_i=>FIELD_URIS[field]}, :message=>{field=>{:text=>"true"}}}})
        @is_read = true
      end

      # Mark this Item as unread
      def mark_unread!
        field = :is_read
        update!({:set_item_field=>{:field_u_r_i=>{:field_u_r_i=>FIELD_URIS[field]}, :message=>{field=>{:text=>"false"}}}})
        @is_read = false
        true
      end

      def deepen!
        return true unless @shallow
        conn = Viewpoint::EWS::EWS.instance
        shape = {:base_shape => 'AllProperties', :body_type => (@text_only ? 'Text' : 'Best')}
        resp = conn.ews.get_item([@item_id], shape) 
        resp = resp.items.shift
        @ews_item = resp[resp.keys.first]
        @shallow = false
        @ews_methods = []
        @ews_methods_undef = []
        init_methods
        true
      end

      # Move this item to a new folder
      # @param [String,Symbol,GenericFolder] new_folder The new folder to move it to. This should
      #   be a subclass of GenericFolder, a DistinguishedFolderId (must me a Symbol) or a FolderId (String)
      def move!(new_folder)
        new_folder = new_folder.id if new_folder.kind_of?(GenericFolder)
        resp = (Viewpoint::EWS::EWS.instance).ews.move_item([@item_id], new_folder)
        if(resp.status == 'Success')
          @item_id = resp.items.first[resp.items.first.keys.first][:item_id][:id]
          @change_key = resp.items.first[resp.items.first.keys.first][:item_id][:change_key]
          true
        else
          raise EwsError, "Could not move item. #{resp.code}: #{resp.message}"
        end
      end

      # Copy this item to a new folder
      # @param [String,Symbol,GenericFolder] new_folder The new folder to move it to. This should
      #   be a subclass of GenericFolder, a DistinguishedFolderId (must me a Symbol) or a FolderId (String)
      # @return [Item] The Item object of the copy
      def copy(new_folder)
        new_folder = new_folder.id if new_folder.kind_of?(GenericFolder)
        resp = (Viewpoint::EWS::EWS.instance).ews.copy_item([@item_id], new_folder)
        if(resp.status == 'Success')
          item = resp.items.first
          i_type = item.keys.first.to_s.camel_case
          return(eval "#{i_type}.new(item[item.keys.first])")
        else
          raise EwsError, "Could not copy item. #{resp.code}: #{resp.message}"
        end
      end

      # Return the attachments for this Item
      # @return [Array,Attachment] An array of Attachments for this Item
      def attachments
        # TODO: should an exception be raised if someone calls this method without first
        # checking has_attachments?
        return [] unless has_attachments?

        # If we've already called this don't waste the time to process attachments again.
        return @attachments if defined?(@attachments)

        deepen!
        @attachments = []
        @ews_item[:attachments].each_pair do |k,v|
          # k should be file_attachment or item_attachment
          if(v.is_a?(Hash))
            @attachments << (eval "#{k.to_s.camel_case}.new(v[:attachment_id][:id])")
          else
            v.each do |att|
              @attachments << (eval "#{k.to_s.camel_case}.new(att[:attachment_id][:id])")
            end
          end
        end
        @attachments
      end

      # Delete this item
      # @param [Boolean] soft Whether or not to do a soft delete.  By default EWS will do a 
      #   hard delete of this item.  See the MSDN docs for more info:
      #   http://msdn.microsoft.com/en-us/library/aa562961.aspx
      # @return [Boolean] Whether or not the item was deleted
      # @todo Add exception handling for failed deletes
      def delete!(soft=false)
        deltype = soft ? 'SoftDelete' : 'HardDelete'
        resp = (Viewpoint::EWS::EWS.instance).ews.delete_item([@item_id], deltype)
        self.clear_object!
        (resp.status == 'Success') || (raise EwsError, "Could not delete message. #{resp.code}: #{resp.message}")
      end

      # Delete this item by moving it to the Deleted Items folder
      # @see  http://msdn.microsoft.com/en-us/library/aa562961.aspx
      # @return [Boolean] Whether or not the item was deleted
      # @todo Add exception handling for failed deletes
      def recycle!
        resp = (Viewpoint::EWS::EWS.instance).ews.delete_item([@item_id], 'MoveToDeletedItems')
        self.clear_object!
        (resp.status == 'Success') || (raise EwsError, "Could not recycle message. #{resp.code}: #{resp.message}")
      end

      # Get the parent folder of this item
      # @return [GenericFolder] returns a GenericFolder of subclass of that type.
      def parent_folder
        #deepen!
        GenericFolder.get_folder @parent_folder_id
      end


      FIELD_URIS= { :folder_id  =>  'older:FolderId', :parent_folder_id  =>  'folder:ParentFolderId', :display_name  =>  'folder:DisplayName',
        :unread_count  =>  'folder:UnreadCount', :total_count  =>  'folder:TotalCount', :child_folder_count  =>  'folder:ChildFolderCount',
        :folder_class  =>  'folder:FolderClass', :search_parameters  =>  'folder:SearchParameters', :managed_folder_information  =>  'folder:ManagedFolderInformation',
        :permission_set  =>  'folder:PermissionSet', :effective_rights  =>  'folder:EffectiveRights', :sharing_effective_rights  =>  'folder:SharingEffectiveRights',
        :item_id  =>  'item:ItemId', :parent_folder_id  =>  'item:ParentFolderId', :item_class  =>  'item:ItemClass', :mime_content  =>  'item:MimeContent',
        :attachments  =>  'item:Attachments', :subject  =>  'item:Subject', :date_time_received  =>  'item:DateTimeReceived', :size  =>  'item:Size',
        :categories  =>  'item:Categories', :has_attachments  =>  'item:HasAttachments', :importance  =>  'item:Importance', :in_reply_to  =>  'item:InReplyTo',
        :internet_message_headers  =>  'item:InternetMessageHeaders', :is_associated  =>  'item:IsAssociated', :is_draft  =>  'item:IsDraft',
        :is_from_me  =>  'item:IsFromMe', :is_resend  =>  'item:IsResend', :is_submitted  =>  'item:IsSubmitted', :is_unmodified  =>  'item:IsUnmodified',
        :date_time_sent  =>  'item:DateTimeSent', :date_time_created  =>  'item:DateTimeCreated', :body  =>  'item:Body', :response_objects  =>  'item:ResponseObjects',
        :sensitivity  =>  'item:Sensitivity', :reminder_due_by  =>  'item:ReminderDueBy', :reminder_is_set  =>  'item:ReminderIsSet',
        :reminder_minutes_before_start  =>  'item:ReminderMinutesBeforeStart', :display_to  =>  'item:DisplayTo', :display_cc  =>  'item:DisplayCc',
        :culture  =>  'item:Culture', :effective_rights  =>  'item:EffectiveRights', :last_modified_name  =>  'item:LastModifiedName',
        :last_modified_time  =>  'item:LastModifiedTime', :conversation_id  =>  'item:ConversationId', :unique_body  =>  'item:UniqueBody',
        :web_client_read_form_query_string  =>  'item:WebClientReadFormQueryString', :web_client_edit_form_query_string  =>  'item:WebClientEditFormQueryString',
        :conversation_index  =>  'message:ConversationIndex', :conversation_topic  =>  'message:ConversationTopic', :internet_message_id  =>  'message:InternetMessageId',
        :is_read  =>  'message:IsRead', :is_response_requested  =>  'message:IsResponseRequested', :is_read_receipt_requested  =>  'message:IsReadReceiptRequested',
        :is_delivery_receipt_requested  =>  'message:IsDeliveryReceiptRequested', :references  =>  'message:References', :reply_to  =>  'message:ReplyTo',
        :from  =>  'message:From', :sender  =>  'message:Sender', :to_recipients  =>  'message:ToRecipients', :cc_recipients  =>  'message:CcRecipients',
        :bcc_recipients  =>  'message:BccRecipients', :associated_calendar_item_id  =>  'meeting:AssociatedCalendarItemId', :is_delegated  =>  'meeting:IsDelegated',
        :is_out_of_date  =>  'meeting:IsOutOfDate', :has_been_processed  =>  'meeting:HasBeenProcessed', :response_type  =>  'meeting:ResponseType',
        :meeting_request_type  =>  'meetingRequest:MeetingRequestType', :intended_free_busy_status  =>  'meetingRequest:IntendedFreeBusyStatus',
        :start  =>  'calendar:Start', :end  =>  'calendar:End', :original_start  =>  'calendar:OriginalStart', :is_all_day_event  =>  'calendar:IsAllDayEvent',
        :legacy_free_busy_status  =>  'calendar:LegacyFreeBusyStatus', :location  =>  'calendar:Location', :when  =>  'calendar:When',
        :is_meeting  =>  'calendar:IsMeeting', :is_cancelled  =>  'calendar:IsCancelled', :is_recurring  =>  'calendar:IsRecurring',
        :meeting_request_was_sent  =>  'calendar:MeetingRequestWasSent', :is_response_requested  =>  'calendar:IsResponseRequested',
        :calendar_item_type  =>  'calendar:CalendarItemType', :my_response_type  =>  'calendar:MyResponseType', :organizer  =>  'calendar:Organizer',
        :required_attendees  =>  'calendar:RequiredAttendees', :optional_attendees  =>  'calendar:OptionalAttendees', :resources  =>  'calendar:Resources',
        :conflicting_meeting_count  =>  'calendar:ConflictingMeetingCount', :adjacent_meeting_count  =>  'calendar:AdjacentMeetingCount',
        :conflicting_meetings  =>  'calendar:ConflictingMeetings', :adjacent_meetings  =>  'calendar:AdjacentMeetings', :duration  =>  'calendar:Duration',
        :time_zone  =>  'calendar:TimeZone', :appointment_reply_time  =>  'calendar:AppointmentReplyTime',
        :appointment_sequence_number  =>  'calendar:AppointmentSequenceNumber', :appointment_state  =>  'calendar:AppointmentState', :recurrence  =>  'calendar:Recurrence',
        :first_occurrence  =>  'calendar:FirstOccurrence', :last_occurrence  =>  'calendar:LastOccurrence', :modified_occurrences  =>  'calendar:ModifiedOccurrences',
        :deleted_occurrences  =>  'calendar:DeletedOccurrences', :meeting_time_zone  =>  'calendar:MeetingTimeZone', :conference_type  =>  'calendar:ConferenceType',
        :allow_new_time_proposal  =>  'calendar:AllowNewTimeProposal', :is_online_meeting  =>  'calendar:IsOnlineMeeting',
        :meeting_workspace_url  =>  'calendar:MeetingWorkspaceUrl', :net_show_url  =>  'calendar:NetShowUrl', :u_i_d  =>  'calendar:UID',
        :recurrence_id  =>  'calendar:RecurrenceId', :date_time_stamp  =>  'calendar:DateTimeStamp', :start_time_zone  =>  'calendar:StartTimeZone',
        :end_time_zone  =>  'calendar:EndTimeZone', :actual_work  =>  'task:ActualWork', :assigned_time  =>  'task:AssignedTime',
        :billing_information  =>  'task:BillingInformation', :change_count  =>  'task:ChangeCount', :companies  =>  'task:Companies',
        :complete_date  =>  'task:CompleteDate', :contacts  =>  'task:Contacts', :delegation_state  =>  'task:DelegationState',
        :delegator  =>  'task:Delegator', :due_date  =>  'task:DueDate', :is_assignment_editable  =>  'task:IsAssignmentEditable', :is_complete  =>  'task:IsComplete',
        :is_recurring  =>  'task:IsRecurring', :is_team_task  =>  'task:IsTeamTask', :mileage  =>  'task:Mileage', :owner  =>  'task:Owner',
        :percent_complete  =>  'task:PercentComplete', :recurrence  =>  'task:Recurrence', :start_date  =>  'task:StartDate', :status  =>  'task:Status',
        :status_description  =>  'task:StatusDescription', :total_work  =>  'task:TotalWork', :assistant_name  =>  'contacts:AssistantName',
        :birthday  =>  'contacts:Birthday', :business_home_page  =>  'contacts:BusinessHomePage', :children  =>  'contacts:Children', :companies  =>  'contacts:Companies',
        :company_name  =>  'contacts:CompanyName', :complete_name  =>  'contacts:CompleteName', :contact_source  =>  'contacts:ContactSource',
        :culture  =>  'contacts:Culture', :department  =>  'contacts:Department', :display_name  =>  'contacts:DisplayName',
        :email_addresses  =>  'contacts:EmailAddresses', :file_as  =>  'contacts:FileAs', :file_as_mapping  =>  'contacts:FileAsMapping',
        :generation  =>  'contacts:Generation', :given_name  =>  'contacts:GivenName', :has_picture  =>  'contacts:HasPicture', :im_addresses  =>  'contacts:ImAddresses',
        :initials  =>  'contacts:Initials', :job_title  =>  'contacts:JobTitle', :manager  =>  'contacts:Manager', :middle_name  =>  'contacts:MiddleName',
        :mileage  =>  'contacts:Mileage', :nickname  =>  'contacts:Nickname', :office_location  =>  'contacts:OfficeLocation', :phone_numbers  =>  'contacts:PhoneNumbers',
        :physical_addresses  =>  'contacts:PhysicalAddresses', :postal_address_index  =>  'contacts:PostalAddressIndex', :profession  =>  'contacts:Profession',
        :spouse_name  =>  'contacts:SpouseName', :surname  =>  'contacts:Surname', :wedding_anniversary  =>  'contacts:WeddingAnniversary',
        :members  =>  'distributionlist:Members', :posted_time  =>  'postitem:PostedTime', :conversation_id  =>  'conversation:ConversationId',
        :conversation_topic  =>  'conversation:ConversationTopic', :unique_recipients  =>  'conversation:UniqueRecipients',
        :global_unique_recipients  =>  'conversation:GlobalUniqueRecipients', :unique_unread_senders  =>  'conversation:UniqueUnreadSenders',
        :global_unique_unread_senders  =>  'conversation:GlobalUniqueUnreadSenders', :unique_senders  =>  'conversation:UniqueSenders',
        :global_unique_senders  =>  'conversation:GlobalUniqueSenders', :last_delivery_time  =>  'conversation:LastDeliveryTime',
        :global_last_delivery_time  =>  'conversation:GlobalLastDeliveryTime', :categories  =>  'conversation:Categories',
        :global_categories  =>  'conversation:GlobalCategories', :flag_status  =>  'conversation:FlagStatus', :global_flag_status  =>  'conversation:GlobalFlagStatus',
        :has_attachments  =>  'conversation:HasAttachments', :global_has_attachments  =>  'conversation:GlobalHasAttachments',
        :message_count  =>  'conversation:MessageCount', :global_message_count  =>  'conversation:GlobalMessageCount', :unread_count  =>  'conversation:UnreadCount',
        :global_unread_count  =>  'conversation:GlobalUnreadCount', :size  =>  'conversation:Size', :global_size  =>  'conversation:GlobalSize',
        :item_classes  =>  'conversation:ItemClasses', :global_item_classes  =>  'conversation:GlobalItemClasses', :importance  =>  'conversation:Importance',
        :global_importance  =>  'conversation:GlobalImportance', :item_ids  =>  'conversation:ItemIds', :global_item_ids  =>  'conversation:GlobalItemIds'}




      private

      # @todo Handle:
      #   <Attachments/> <Categories/> <InternetMessageHeaders/> <ResponseObjects/>
      #   <ExtendedProperty/> <EffectiveRights/>
      def init_methods
        @parent_folder_id = @ews_item[:parent_folder_id][:id] if @ews_item[:parent_folder_id].is_a?(Hash)
        @conversation_id  = @ews_item[:conversation_id][:id] if @ews_item[:conversation_id].is_a?(Hash)
        @ews_methods << :item_id
        define_str_var :subject, :sensitivity, :body, :item_class, :importance, :in_reply_to, :unique_body
        define_str_var :display_cc, :display_to, :culture, :last_modified_name, :mime_content
        define_str_var :web_client_read_form_query_string, :web_client_edit_form_query_string
        define_attr_str_var :body, :body_type
        define_attr_str_var :unique_body, :body_type
        define_attr_str_var :mime_content, :character_set
        define_int_var :size, :reminder_minutes_before_start
        define_bool_var :has_attachments, :is_submitted, :is_draft, :is_from_me, :is_resend, :is_unmodified, :reminder_is_set, :is_associated
        define_datetime_var :date_time_sent, :date_time_created, :date_time_received, :reminder_due_by, :last_modified_time
      end

      def method_missing(m, *args, &block)
        if(@shallow)
          deepen!
          send(m, *args, &block)
        else
          warn "!!! No such method: #{m}" if $DEBUG
          nil
        end
      end

    end # Item
  end # EWS
end # Viewpoint
