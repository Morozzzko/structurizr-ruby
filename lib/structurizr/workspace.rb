# frozen_string_literal: true

require 'structurizr/metal'
require 'structurizr/utils'
require 'structurizr/model'
require 'structurizr/enterprise'

module Structurizr
  class Workspace < DelegateClass(Metal::Root::Workspace)
    attr_reader :workspace
    def initialize(name, description)
      @workspace = Metal::Root::Workspace.new(name, description)

      super(@workspace)
    end

    alias to_java workspace

    def to_json(*_args)
      Metal::Util::WorkspaceUtils.to_json(to_java, false)
    end
  end
end
