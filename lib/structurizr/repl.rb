# frozen_string_literal: true

require 'pry'
require 'structurizr/repl/commands'

module Structurizr
  module REPL
    # Simple module which defines a reader for a nested attribute
    module Delegation
      def delegate(*methods, to:)
        methods.each do |method|
          define_method method do
            public_send(to).public_send(method)
          end
        end
      end
    end

    InvalidWorkspaceFileError = Class.new(StandardError)

    class Context
      extend Delegation

      attr_reader :workspace

      delegate :model, to: :workspace
      delegate :relationships, :elements, :software_systems, :people, to: :model

      def initialize(workspace)
        @workspace = workspace
      end
    end

    class Application
      attr_reader :context, :workspace_path, :argv

      def initialize(argv)
        @argv = argv
      end

      def parse_workspace_path!
        @workspace_path =
          if (input_path = argv.first) && File.file?(input_path)
            argv.first
          else
            puts 'Usage: structurizr-repl <path/to/structurizr.json>'

            raise InvalidWorkspaceFileError, 'Please specify a valid path'
          end
      end

      def prepare_context!
        @context = Structurizr::REPL::Context.new(
          Structurizr::Workspace.from_json(
            File.read(workspace_path)
          )
        )
      end

      def setup_pry!
        setup_welcome_message
        register_commands
      end

      def start
        Pry.start(context)
      end

      private

      def register_commands
        Pry::Commands.add_command Structurizr::REPL::Commands::Workspace
        Pry::Commands.add_command Structurizr::REPL::Commands::Model
        Pry::Commands.import Structurizr::REPL::Commands::Shortcuts::All
      end

      def setup_welcome_message
        Pry.hooks.add_hook(
          :before_session,
          :structurizr_welcome_message
        ) do |output, _binding, _pry|
          output.puts <<~ECHO
            Welcome to Structurizr REPL

            Type `help structurizr` to get a list of commands
          ECHO
        end
      end
    end
  end
end
