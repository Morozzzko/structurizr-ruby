# frozen_string_literal: true

require 'structurizr/utils'
require 'structurizr/metal'

module Structurizr
  class Tags < DelegateClass(Metal::Model::Tags)
    extend Utils::JavaEnum[Metal::Model::Tags]
  end
end
