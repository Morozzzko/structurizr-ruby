# frozen_string_literal: true

require 'structurizr/metal'

module Structurizr
  module InteractionStyle
    def self.Synchronous
      Metal::Model::InteractionStyle::Synchronous
    end

    def self.Asynchronous
      Metal::Model::InteractionStyle::Asynchronous
    end
  end
end
