# frozen_string_literal: true

require 'structurizr/metal'

module Structurizr
  module Location
    def self.Internal # rubocop:disable Naming/MethodName
      Metal::Model::Location::Internal
    end

    def self.External # rubocop:disable Naming/MethodName
      Metal::Model::Location::External
    end
  end
end
