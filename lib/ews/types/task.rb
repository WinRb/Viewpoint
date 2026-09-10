# frozen_string_literal: true

module Viewpoint
  module EWS
    module Types
      class Task
        include Viewpoint::EWS
        include Viewpoint::EWS::Types
        include Viewpoint::EWS::Types::Item

        TASK_KEY_PATHS = {
          complete?: %i[is_complete text],
          recurring?: %i[is_recurring text],
          start_date: %i[start_date text],
          due_date: %i[end_date text],
          reminder_due_by: %i[reminder_due_by text],
          reminder?: %i[reminder_is_set text],
          percent_complete: %i[percent_complete text],
          status: %i[status text]
        }

        TASK_KEY_TYPES = {
          recurring?: ->(str) { str.downcase == 'true' },
          complete?: ->(str) { str.downcase == 'true' },
          reminder?: ->(str) { str.downcase == 'true' },
          percent_complete: lambda(&:to_i)
        }
        TASK_KEY_ALIAS = {}

        private

        def key_paths
          super.merge(TASK_KEY_PATHS)
        end

        def key_types
          super.merge(TASK_KEY_TYPES)
        end

        def key_alias
          super.merge(TASK_KEY_ALIAS)
        end
      end
    end
  end
end
