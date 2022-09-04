# frozen_string_literal: true

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
          'People' => 'people',
          'SoftwareSystems' => 'software_systems'
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
  end
end
