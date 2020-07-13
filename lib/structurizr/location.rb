# frozen_string_literal: true

require 'structurizr/utils'
require 'structurizr/metal'

module Structurizr
  class Location < DelegateClass(Metal::Model::Location)
    extend Utils::JavaEnum[Metal::Model::Location]
  end
end
