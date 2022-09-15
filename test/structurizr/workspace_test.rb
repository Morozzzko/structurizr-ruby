# frozen_string_literal: true

require 'test_helper'

module Structurizr
  class WorkspaceTest < Minitest::Test
    attr_reader :workspace

    def setup
      @workspace = Structurizr::Workspace.new('Name', 'Description')
    end

    def test_workspace
      refute_nil workspace.model
    end

    def test_inspect
      assert_equal %{#<Structurizr::Workspace("Name")>}, workspace.inspect
    end
  end
end
