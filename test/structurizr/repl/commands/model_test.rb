# frozen_string_literal: true

require 'test_helper'
require 'structurizr/repl'

module Structurizr
  module REPL
    module Commands
      class ModelTest < Minitest::Test
        attr_reader :command, :output, :workspace

        def setup
          @workspace = Structurizr::Workspace.new('Test workspace', 'Testing commands')
          @output = StringIO.new
          @command = Structurizr::REPL::Commands::Model.new(
            output: @output,
            target: binding
          )
        end

        def test_access_to_workspace_model
          assert_equal workspace.model, command.call
        end
      end
    end
  end
end
