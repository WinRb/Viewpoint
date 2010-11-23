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
    # This is the base model Module for shared code among all Model classes.
    # @attr_reader [Array] :ews_methods The EWS methods created for this Model.
    module Model

      # These are convenience methods to quickly create instance methods for
      # the various Model types when passed a Hash from the SOAP parser.
      # These functions depend on each model type saving the passed Hash
      # in an instance variable called @ews_item.

      attr_reader :ews_methods, :ews_methods_undef

      def initialize
        # Defined EWS methods
        @ews_methods = []
        # Undefined EWS methods
        @ews_methods_undef = []
      end

      protected

      # Define a method that returns a string.  The vars are the keys in the 
      # hash that contain a :text key.  In the original SOAP packet this would
      # look something like this:
      # @param [Array<Symbol,Hash>] *vars the symbols to map to methods.  If the
      #   last item is a hash it will be used to map methods names.  For instance
      #   UID comes through like this :u_i_d so we can map it like so {:u_i_d => :uid}
      # @example
      #   <method_name>
      #      This is the text
      #   </method_name>
      def define_str_var(*vars)
        map = ( vars.last.is_a?(Hash) ? vars.pop : {}) 
        vars.each do |var|
          if(@ews_item[var])
            mname = ( map.has_key?(var) ? map[var] : var )
            @ews_methods << mname
            self.instance_eval <<-EOF
            def #{mname}
              @ews_item[:#{var}][:text]
            end
            EOF
          else
            @ews_methods_undef << var
          end
        end
      end

      # This is similar to the #define_str_var method except of the text value
      # is from an XML attribute in the original SOAP so the text won't be pointed
      # to by :text.  In the orignal SOAP it may have looked like this:
      # @example
      #   <node my_method='this is the text'/>
      #   so you would specify this...
      #   define_attr_str_var :node, :my_method
      def define_attr_str_var(parent, *vars)
        return unless @ews_item[parent]
        vars.each do |var|
          if(@ews_item[parent][var])
            @ews_methods << var
            self.instance_eval <<-EOF
            def #{var}
              @ews_item[:#{parent}][:#{var}]
            end
            EOF
          else
            @ews_methods_undef << var
          end
        end
      end
      

      def define_int_var(*vars)
        vars.each do |var|
          if(@ews_item[var])
            @ews_methods << var
            self.instance_eval <<-EOF
            def #{var}
              @#{var} ||= @ews_item[:#{var}][:text].to_i
            end
            EOF
          else
            @ews_methods_undef << var
          end
        end
      end

      def define_bool_var(*vars)
        vars.each do |var|
          if(@ews_item[var])
            @ews_methods << "#{var}?".to_sym
            self.instance_eval <<-EOF
            def #{var}?
              @#{var} ||= (@ews_item[:#{var}][:text] == 'true') ? true : false
            end
            EOF
          else
            @ews_methods_undef << "#{var}?".to_sym
          end
        end
      end

      def define_datetime_var(*vars)
        vars.each do |var|
          if(@ews_item[var])
            @ews_methods << var
            self.instance_eval <<-EOF
            def #{var}
              @#{var} ||= DateTime.parse(@ews_item[:#{var}][:text])
            end
            EOF
          else
            @ews_methods_undef << var
          end
        end
      end

      def define_mbox_users(*vars)
        vars.each do |var|
          if(@ews_item[var])
            @ews_methods << var
            self.instance_eval <<-EOF
            def #{var}
              return @#{var} if defined?(@#{var})
              if( (@ews_item[:#{var}][:mailbox]).is_a?(Hash) )
                @#{var} = [MailboxUser.new(@ews_item[:#{var}][:mailbox])]
              elsif( (@ews_item[:#{var}][:mailbox]).is_a?(Array) )
                @#{var} = []
                @ews_item[:#{var}][:mailbox].each do |i|
                  @#{var} << MailboxUser.new(i)
                end
              else
                raise EwsError, "Bad value for mailbox: " + @ews_item[:#{var}][:mailbox]
              end
              @#{var}
            end
            EOF
          else
            @ews_methods_undef << var
          end
        end
      end


      def define_mbox_user(*vars)
        vars.each do |var|
          if(@ews_item[var])
            @ews_methods << var
            self.instance_eval <<-EOF
            def #{var}
              @#{var} ||= MailboxUser.new(@ews_item[:#{var}][:mailbox])
            end
            EOF
          else
            @ews_methods_undef << var
          end
        end
      end
      

      # Define meeting attendees
      # @param [String] *attendee_types the type of attendee we are defining :required_attendees, :optional_attendees
      def define_attendees(*attendee_types)
        attendee_types.each do |attendee_type|
          if(@ews_item.has_key?(attendee_type))
            @ews_methods << attendee_type
            self.instance_eval <<-EOF
            def #{attendee_type}
              return @#{attendee_type} if defined?(@#{attendee_type})
              if( (@ews_item[:#{attendee_type}][:attendee]).is_a?(Hash) )
                @#{attendee_type} = [Attendee.new(@ews_item[:#{attendee_type}][:attendee])]
              elsif( (@ews_item[:#{attendee_type}][:attendee]).is_a?(Array) )
                @#{attendee_type} = []
                @ews_item[:#{attendee_type}][:attendee].each do |i|
                  @#{attendee_type} << Attendee.new(i)
                end
              else
                raise EwsError, "Bad value for mailbox: " + @ews_item[:#{attendee_type}][:attendee]
              end
              @#{attendee_type}
            end
            EOF
          else
            @ews_methods_undef << var
          end
        end
      end


      # After a delete is called on an object this method will clear
      # out all of the defined EWS methods so they can't be called on the
      # instantiated object.
      def clear_object!
        @ews_methods.each do |m|
          self.instance_variables.each do |iv|
            self.instance_variable_set("#{iv}",nil)
          end
        end
      end

    end # Model
  end # EWS
end # Viewpoint
