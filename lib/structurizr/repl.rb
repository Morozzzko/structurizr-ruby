# frozen_string_literal: true

require 'pry'

module Structurizr
  module REPL
    module Commands
      class Workspace < Pry::ClassCommand
        match "workspace"
        description "Access current workspace"
        group "Structurizr"
        command_options keep_retval: true

        def process
          target_self.workspace
        end
      end

      class Model < Pry::ClassCommand
        match "model"
        description "Access current workspace's model"
        group "Structurizr"
        command_options keep_retval: true

        def process
          target_self.workspace.model
        end
      end

      module Shortcuts
        All = Pry::CommandSet.new

        {
          'Relationships' => 'relationships',
          'Elements' => 'elements',
          'People' => 'people'
        }.each do |class_name, attribute_name|
          shortcut_class = Class.new(Pry::ClassCommand) do
            match attribute_name
            description "Access model's #{attribute_name}"
            group "Structurizr"
            command_options keep_retval: true

            define_method :process do
              target_self.workspace.model.public_send(attribute_name.to_sym)
            end
          end

          const_set(class_name, shortcut_class)

          All.add_command shortcut_class
        end
      end
    end

    module Delegation
      def delegate(*methods, to:)
        methods.each do |method|
          define_method method do
            public_send(to).public_send(method)
          end
        end
      end
    end

    class Context
      extend Delegation

      attr_reader :workspace

      delegate :model, to: :workspace
      delegate :relationships, :elements, :software_systems, :people, to: :model

      def initialize(workspace_path)
        @workspace = Structurizr::Workspace.from_json(File.read(workspace_path))
      end
    end
  end
end
