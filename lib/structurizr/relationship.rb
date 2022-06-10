# frozen_string_literal: true

require 'structurizr/metal'

module Structurizr
  Relationship = Metal::Model::Relationship

  class Relationship
    def inspect
      %(<Relationship: #{source.name} -> #{destination.name}>)
    end
  end
end
