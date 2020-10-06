# frozen_string_literal: true

require 'structurizr/utils'
require 'structurizr/metal'

module Structurizr
  class Routing < DelegateClass(Metal::View::Routing)
    extend Utils::JavaEnum[Metal::View::Routing]
  end
end
