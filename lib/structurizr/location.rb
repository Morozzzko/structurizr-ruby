# frozen_string_literal: true

require 'structurizr/metal'

module Structurizr
  Location = Metal::Model::Location

  class Location
    def inspect
      %(#<Structurizr::Location::#{name}>)
    end
  end
end
