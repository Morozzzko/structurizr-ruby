# frozen_string_literal: true

require 'structurizr/utils'
require 'structurizr/metal'

module Structurizr
  class InteractionStyle < DelegateClass(Metal::Model::InteractionStyle)
    extend Utils::JavaEnum[Metal::Model::InteractionStyle]
  end
end
