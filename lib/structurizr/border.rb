# frozen_string_literal: true

require 'structurizr/utils'
require 'structurizr/metal'

module Structurizr
  class Border < DelegateClass(Metal::View::Border)
    extend Utils::JavaEnum[Metal::View::Border]
  end
end
