# frozen_string_literal: true

require 'structurizr/metal'

module Structurizr
  Model = Metal::Model::Model

  class Model
    def inspect
      %{<Model: "#{name}">}
    end
  end
end
