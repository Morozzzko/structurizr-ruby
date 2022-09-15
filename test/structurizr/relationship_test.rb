# frozen_string_literal: true

require 'test_helper'

module Structurizr
  class RelationshipTest < Minitest::Test
    attr_reader :workspace, :software_system, :relationship, :afferent_element, :efferent_element

    def setup
      @workspace = Structurizr::Workspace.new('Name', 'Description')
      @software_system = workspace.model.add_software_system(Location::Internal, 'My Software System', 'Does useful stuff!')
      @afferent_element = software_system.add_container('Backend')
      @efferent_element = software_system.add_container('Frontend')
      @relationship = afferent_element.uses(efferent_element, 'does something using', 'GraphQL')
    end

    def test_inspect
      assert_equal %{#<"Backend" -> "Frontend" "does something using" "GraphQL">}, relationship.inspect
    end
  end
end
