# frozen_string_literal: true

require 'test_helper'
require 'structurizr/repl'

module Structurizr
  module REPL
    module Commands
      class WorkspaceTest < Minitest::Test
        attr_reader :command, :output, :workspace

        def setup
          @workspace = Structurizr::Workspace.new('Test workspace', 'Testing commands')
          @output = StringIO.new
          @command = Structurizr::REPL::Commands::Workspace.new(
            output: @output,
            target: binding
          )
        end

        def test_access_to_workspace
          assert_equal command.call, workspace
        end
      end
    end
  end
end
