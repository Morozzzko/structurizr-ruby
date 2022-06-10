# frozen_string_literal: true

require 'structurizr/metal'

module Structurizr
  Person = Metal::Model::Person

  class Person
    def inspect
      %(<Person: "#{name}">)
    end
  end
end
