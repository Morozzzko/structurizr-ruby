# frozen_string_literal: true

require 'structurizr/metal'
require 'structurizr/utils'
require 'structurizr/model'
require 'structurizr/enterprise'

module Structurizr
  class Workspace < DelegateClass(Metal::Root::Workspace)
    include Utils::DecamelizeMethods

    attr_reader :workspace
    def initialize(name, description)
      @workspace = Metal::Root::Workspace.new(name, description)

      super(@workspace)
    end
  end
end
