# frozen_string_literal: true

module Structurizr
  module Utils
    # This is a helpful utility to make Java enums quack properly
    # When we copy and paste Java code, we usually get code like this:
    # Shape.OVAL
    # Tags.SOFTWARE_SYSTEM
    #
    # Those things are accessible as Tags::SOFTWARE_SYSTEM. However, we can't access the constants via dot,
    # as it's the method call in Ruby. It may be easier to support two ways of access now. It may be deprecated in future
    module JavaEnum
      def self.[](bare_class)
        ::Module.new do
          define_method :method_missing do |method_name, *, **|
            if bare_class.constants.include?(method_name)
              bare_class.const_get(method_name)
            else
              super
            end
          end
        end
      end
    end
  end
end
