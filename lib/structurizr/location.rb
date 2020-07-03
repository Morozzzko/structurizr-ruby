# frozen_string_literal: true

require 'structurizr/metal'

module Structurizr
  module Location
    def self.Internal
      Metal::Model::Location::Internal
    end

    def self.External
      Metal::Model::Location::External
    end
  end
end
