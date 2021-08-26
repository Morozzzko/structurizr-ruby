# frozen_string_literal: true

require 'structurizr/metal'
require 'structurizr/utils'
require 'structurizr/model'
require 'structurizr/enterprise'

module Structurizr
  Workspace = Metal::Root::Workspace

  class Workspace
    def to_json(*_args)
      Metal::Util::WorkspaceUtils.to_json(self, true)
    end

    def self.from_json(json)
      Metal::Util::WorkspaceUtils.from_json(json)
    end
  end
end
