# frozen_string_literal: true

require 'structurizr/metal'
require 'structurizr/utils'

module Structurizr
  class Enterprise < DelegateClass(Metal::Model::Enterprise)
    include Utils::DynamicAttributes

    attr_reader :enterprise

    def initialize(name)
      @enterprise = Metal::Model::Enterprise.new(name)

      super(@enterprise)
    end

    def to_java
      enterprise
    end
  end
end
