# frozen_string_literal: true

require 'structurizr/metal'
require 'structurizr/utils'

module Structurizr
  class Container < DelegateClass(Metal::Model::Container)
    include Utils::DecamelizeMethods
    include Utils::DynamicAttributes

    attr_reader :container

    def initialize(*args)
      @container = Metal::Model::Container.new(*args)

      super(container)
    end
  end
end
