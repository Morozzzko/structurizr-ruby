# frozen_string_literal: true

require 'structurizr/utils'
require 'structurizr/metal'

module Structurizr
  class FilterMode < DelegateClass(Metal::View::FilterMode)
    extend Utils::JavaEnum[Metal::View::FilterMode]
  end
end
