# frozen_string_literal: true

require 'structurizr/metal'

module Structurizr
  Container = Metal::Model::Container

  class Container
    def inspect
      %{<Container: "#{name}">}
    end
  end
end
