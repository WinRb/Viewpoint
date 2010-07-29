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

      def define_str_var(*vars)
        vars.each do |var|
          if(@ews_item[var])
            @ews_methods << var
            self.instance_eval <<-EOF
            def #{var.to_s}
              @ews_item[:#{var}][:text]
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
