# frozen_string_literal: true

require 'test_helper'
require 'structurizr/repl'

module Structurizr
  module REPL
    module Commands
      class ShortcutsTest < Minitest::Test
        attr_reader :command, :output, :workspace, :command_set

        def setup
          @workspace = Structurizr::Workspace.new('Test workspace', 'Testing commands')
          @output = StringIO.new
          @command = Structurizr::REPL::Commands::Shortcuts::Relationships.new(
            output: @output,
            target: binding
          )
          @command_set = Structurizr::REPL::Commands::Shortcuts::All
        end

        def test_shortcut_command_to_workspace_model_relationships
          assert_equal command.call, workspace.model.relationships
        end

        def test_all_shortcut_commands
          commands = command_set.list_commands

          assert_includes commands, 'relationships'
          assert_includes commands, 'elements'
          assert_includes commands, 'software_systems'
          assert_includes commands, 'people'
        end
      end
    end
  end
end
