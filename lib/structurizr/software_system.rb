# frozen_string_literal: true

require 'structurizr/metal'

module Structurizr
  SoftwareSystem = Metal::Model::SoftwareSystem

  class SoftwareSystem
    def inspect
      %(<SoftwareSystem: "#{name}">)
    end
  end
end
