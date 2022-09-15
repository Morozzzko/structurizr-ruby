# frozen_string_literal: true

require 'structurizr/metal'

module Structurizr
  Relationship = Metal::Model::Relationship

  class Relationship
    def inspect
      parts = [
        "#{source.name.inspect} -> #{destination.name.inspect}",
        description.inspect,
        technology.inspect
      ].reject(&:empty?).join(" ")

      %(#<#{parts}>)
    end
  end
end
