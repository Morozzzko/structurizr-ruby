# frozen_string_literal: true

require 'structurizr/metal'

module Structurizr
  Model = Metal::Model::Model

  class Model
    def elements
      get_elements.to_a
    end
  end
end
