# frozen_string_literal: true

require 'structurizr/utils/inflector'

module Structurizr
  module Utils
    # We use this mixin to automatically transform all camelcase methods to snake_case
    # Naturally, Java libraries use camelCase, while Ruby prefers snake_case
    # It may be better to transform all methods automatically for now, instead of doing it manually
    module DecamelizeMethods
      def self.included(klass)
        klass.methods.grep(/[A-Z]/).each do |method_name|
          underscore_name = Inflector.underscore(method_name.to_s).to_sym
          klass.alias_method underscored_name method_name
        end
      end
    end
  end
end
