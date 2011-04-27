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

module Viewpoint
  module EWS
    class Task < Item
      

      # Create a Task in the Exchange Data Store from a hash
      # @param [Hash] item A Hash of values based on values found here:
      #   http://msdn.microsoft.com/en-us/library/aa563930.aspx
      # @param [String, Symbol] folder_id The folder to create this item in. Either a
      #   DistinguishedFolderId (must me a Symbol) or a FolderId (String)
      # @param [String] disposition SaveOnly/SendOnly/SendAndSaveCopy
      #   See:  http://msdn.microsoft.com/en-us/library/aa565209.aspx
      # @example Typical Usage
      #   item = {
      #     :subject => {:text => 'Planning'},
      #     :body => {:body_type => 'Text', :text => 'This is a test'},
      #     :start_date => {:text => '2010-07-29T14:00:00'},
      #     :due_date => {:text => '2010-07-29T15:00:00'},
      #   }
      # @example Minimal Usage
      #   item = {:subject => {:text => 'This is a test'}}
      def self.create_item_from_hash(item, folder_id = :tasks, disposition = 'SaveOnly')
        conn = Viewpoint::EWS::EWS.instance
        resp = conn.ews.create_task_item(folder_id, item, disposition)
        if(resp.status == 'Success')
          resp = resp.items.shift
          self.new(resp[resp.keys.first])
        else
          raise EwsError, "Could not create Task. #{resp.code}: #{resp.message}"
        end
      end

      # Create a Task in the Exchange Data Store
      #
      # @param [nil, String] folder the folder to add the task to. If it is nil
      #   the Task will be placed in the default Task folder.
      # @param [String] subject The task subject
      # @param [String] body The task body
      # @param [DateTime] v_start The date/time when this task begins
      # @param [DateTime] v_end The date/time when this task is due
      # @param [Symbol] status The current status of this task
      #   :completed, :in_progress, :waiting_on_others, 
      def self.create_task(folder, subject, body, v_start = nil, v_end = nil, status = nil)
        item = {}
        item[:subject] = {:text => subject}
        item[:body] = {:text => body, :body_type => 'Text'} unless body.nil?
        item[:start_date] = {:text => v_start.to_s} unless v_start.nil?
        item[:due_date] = {:text => v_end.to_s} unless v_end.nil?
        item[:status] = {:text => status} unless status.nil?
        
        self.create_item_from_hash(item, folder)
      end


      # Initialize an Exchange Web Services item of type Task
      def initialize(ews_item, opts={})
        super(ews_item, opts)
      end

      # Delete this item
      # @param [Boolean] soft Whether or not to do a soft delete.  By default EWS will do a 
      #   hard delete of this item.  See the MSDN docs for more info:
      #   http://msdn.microsoft.com/en-us/library/aa562961.aspx
      # @param [String, nil] affected_task_occurrences "AllOccurrences/SpecifiedOccurrenceOnly"
      #   Default is AllOccurrences
      #   If you use 'SpecifiedOccurrenceOnly' on a non-reocurring task you will receive and error.
      # @return [Boolean] Whether or not the item was deleted
      # @todo Add exception handling for failed deletes
      #
      def delete!(soft=false, affected_task_occurrences='AllOccurrences')
        deltype = soft ? 'SoftDelete' : 'HardDelete'
        resp = (Viewpoint::EWS::EWS.instance).ews.delete_item([@item_id], deltype, nil, affected_task_occurrences)
        self.clear_object!
        resp.status == 'Success'
      end

      # Delete this item by moving it to the Deleted Items folder
      # @see  http://msdn.microsoft.com/en-us/library/aa562961.aspx
      # @param [String, nil] affected_task_occurrences "AllOccurrences/SpecifiedOccurrenceOnly"
      #   Default is AllOccurrences
      #   If you use 'SpecifiedOccurrenceOnly' on a non-reocurring task you will receive and error.
      # @return [Boolean] Whether or not the item was deleted
      # @todo Add exception handling for failed deletes
      def recycle!(affected_task_occurrences='AllOccurrences')
        resp = (Viewpoint::EWS::EWS.instance).ews.delete_item([@item_id], 'MoveToDeletedItems', nil, affected_task_occurrences)
        self.clear_object!
        resp.status == 'Success'
      end


      private

      def init_methods
        super
        define_str_var :status, :owner
        define_bool_var :is_complete, :is_recurring, :is_team_task
        define_int_var :percent_complete, :actual_work, :change_count
        define_datetime_var :start_date, :due_date, :complete_date
      end

    end # Task
  end # EWS
end # Viewpoint
