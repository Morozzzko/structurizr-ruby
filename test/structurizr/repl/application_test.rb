# frozen_string_literal: true

require 'test_helper'
require 'structurizr/repl'

module Structurizr
  module REPL
    class ApplicationTest < Minitest::Test
      def test_empty_path
        stdout, _stderr = capture_io do
          assert_raises InvalidWorkspaceFileError do
            Structurizr::REPL::Application.new([]).parse_workspace_path!
          end
        end

        assert_equal <<~OUTPUT, stdout
          Usage: structurizr-repl <path/to/structurizr.json>
        OUTPUT
      end

      def test_directory
        workspace_path = __dir__

        stdout, _stderr = capture_io do
          assert_raises InvalidWorkspaceFileError do
            Structurizr::REPL::Application.new([workspace_path]).parse_workspace_path!
          end
        end

        assert_equal <<~OUTPUT, stdout
          Usage: structurizr-repl <path/to/structurizr.json>
        OUTPUT
      end

      def test_happy_path
        workspace_path = File.join(__dir__, 'fixtures/', 'workspace.json')

        application = Structurizr::REPL::Application.new([workspace_path])

        application.parse_workspace_path!
        application.prepare_context!
        application.setup_pry!
        application.stub :start, nil do
          # noop
        end
      end
    end
  end
end
