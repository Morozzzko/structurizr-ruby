# frozen_string_literal: true

module Structurizr
  module Utils
    # This module allows us to define attributes and their accessors dynamically
    # It's useful because it enables us to nest definitions. Even without a custom DSL, we can do:
    # workspace.model.tap do |model|
    #   model.big_bank_plc = model.software_system("Big Bank plc")
    # end
    #
    # If we try to do this without having a dedicated logic, we'll fail with an exception
    module DynamicAttributes
      def method_missing(method_name, *values)
        method_name_stringified = method_name.to_s

        if method_name_stringified.end_with?('=')
          attribute_name = method_name_stringified.tr('=', '')

          instance_variable_name = :"@#{attribute_name}"

          define_singleton_method(attribute_name) do
            instance_variable_get(instance_variable_name)
          end

          value = values.first

          instance_variable_set(instance_variable_name, value)
        else
          super
        end
      end
    end
  end
end
