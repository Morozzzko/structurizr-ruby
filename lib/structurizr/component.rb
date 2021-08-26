# frozen_string_literal: true

require 'structurizr/metal'

module Structurizr
  Component = Metal::Model::Component

  class Component
    def inspect
      %{<Component: "#{name}">}
    end
  end
end
