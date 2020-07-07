# frozen_string_literal: true

require 'structurizr/metal'
require 'structurizr/utils'

module Structurizr
  class Model < DelegateClass(Metal::Model::Model)
    include Utils::DynamicAttributes
  end
end
