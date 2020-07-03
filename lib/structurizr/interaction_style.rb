# frozen_string_literal: true

require 'structurizr/metal'

module Structurizr
  module InteractionStyle
    def self.Synchronous # rubocop:disable Naming/MethodName
      Metal::Model::InteractionStyle::Synchronous
    end

    def self.Asynchronous # rubocop:disable Naming/MethodName
      Metal::Model::InteractionStyle::Asynchronous
    end
  end
end
