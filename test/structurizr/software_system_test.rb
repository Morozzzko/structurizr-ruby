# frozen_string_literal: true

require 'test_helper'

module Structurizr
  class SoftwareSystemTest < Minitest::Test
    attr_reader :workspace, :software_system

    def setup
      @workspace = Structurizr::Workspace.new('Name', 'Description')
      @software_system = workspace.model.add_software_system(Location::Internal, 'My Software System', 'Does useful stuff!')
    end

    def test_inspect
      assert_equal %{#<Structurizr::SoftwareSystem("My Software System")>}, software_system.inspect
    end
  end
end
