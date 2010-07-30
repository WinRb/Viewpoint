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
      
      # Create a Task in the Exchange Data Store
      #
      # @param [String] subject The task subject
      # @param [String] body The task body
      # @param [DateTime] v_start The date/time when this task begins
      # @param [DateTime] v_end The date/time when this task is due
      def self.create_task(subject, body, v_start = nil, v_end = nil)
        item = {}
        item[:subject] = {:text => subject}
        item[:body] = {:text => body, :body_type => 'Text'} unless body.nil?
        item[:start_date] = {:text => v_start.to_s} unless v_start.nil?
        item[:due_date] = {:text => v_end.to_s} unless v_end.nil?
        
        conn = Viewpoint::EWS::EWS.instance
        resp = conn.ews.create_task_item(nil, item, 'SaveOnly')
        if(resp.status == 'Success')
          resp = resp.items.shift
          self.new(resp[resp.keys.first])
        else
          raise EwsError, "Could not create task. #{resp.code}: #{resp.message}"
        end
      end


      # Initialize an Exchange Web Services item of type Task
      def initialize(ews_item)
        super(ews_item)
      end

      private

      def init_methods
        super()
      end

    end # Task
  end # EWS
end # Viewpoint
