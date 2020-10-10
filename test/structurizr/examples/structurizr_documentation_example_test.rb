# frozen_string_literal: true

###
# An empty software architecture document using the Structurizr template.
#
# Source: https://github.com/structurizr/java/blob/e0db7582dc6dc7053ab995d7fff44c27d021312e/structurizr-examples/src/com/structurizr/example/StructurizrDocumentationExample.java
# Updated at: 2017-07-25
module Structurizr
  module Examples
    class StructurizrDocumentationExample < Minitest::Test
      attr_reader :template, :software_system

      def setup
        workspace = Workspace.new('Documentation - Structurizr', 'An empty software architecture document using the Structurizr template.')
        model = workspace.get_model
        views = workspace.get_views

        user = model.add_person('User', 'A user of my software system.')
        @software_system = model.add_software_system('Software System', 'My software system.')
        user.uses(software_system, 'Uses')

        contextView = views.create_system_context_view(software_system, 'SystemContext', 'An example of a System Context diagram.')
        contextView.add_all_software_systems
        contextView.add_all_people

        styles = views.get_configuration.get_styles
        styles.add_element_style(Tags::PERSON).shape(Shape::Person)

        @template = StructurizrDocumentationTemplate.new(workspace.to_java)
      end

      def test_markdown
        documentationRoot = java.io.File.new(File.join(__dir__, 'documentation/structurizr/markdown'))
        template.add_context_section(software_system, java.io.File.new(documentationRoot, '01-context.md'))
        template.add_functional_overview_section(software_system, java.io.File.new(documentationRoot, '02-functional-overview.md'))
        template.add_quality_attributes_section(software_system, java.io.File.new(documentationRoot, '03-quality-attributes.md'))
        template.add_constraints_section(software_system, java.io.File.new(documentationRoot, '04-constraints.md'))
        template.add_principles_section(software_system, java.io.File.new(documentationRoot, '05-principles.md'))
        template.add_software_architecture_section(software_system, java.io.File.new(documentationRoot, '06-software-architecture.md'))
        template.add_data_section(software_system, java.io.File.new(documentationRoot, '07-data.md'))
        template.add_infrastructure_architecture_section(software_system, java.io.File.new(documentationRoot, '08-infrastructure-architecture.md'))
        template.add_deployment_section(software_system, java.io.File.new(documentationRoot, '09-deployment.md'))
        template.add_development_environment_section(software_system, java.io.File.new(documentationRoot, '10-development-environment.md'))
        template.add_operation_and_support_section(software_system, java.io.File.new(documentationRoot, '11-operation-and-support.md'))
        template.add_decision_log_section(software_system, java.io.File.new(documentationRoot, '12-decision-log.md'))
      end

      def test_asciidoc
        documentationRoot = java.io.File.new(File.join(__dir__, 'documentation/structurizr/asciidoc'))
        template.add_context_section(software_system, java.io.File.new(documentationRoot, '01-context.adoc'))
        template.add_functional_overview_section(software_system, java.io.File.new(documentationRoot, '02-functional-overview.adoc'))
        template.add_quality_attributes_section(software_system, java.io.File.new(documentationRoot, '03-quality-attributes.adoc'))
        template.add_constraints_section(software_system, java.io.File.new(documentationRoot, '04-constraints.adoc'))
        template.add_principles_section(software_system, java.io.File.new(documentationRoot, '05-principles.adoc'))
        template.add_software_architecture_section(software_system, java.io.File.new(documentationRoot, '06-software-architecture.adoc'))
        template.add_data_section(software_system, java.io.File.new(documentationRoot, '07-data.adoc'))
        template.add_infrastructure_architecture_section(software_system, java.io.File.new(documentationRoot, '08-infrastructure-architecture.adoc'))
        template.add_deployment_section(software_system, java.io.File.new(documentationRoot, '09-deployment.adoc'))
        template.add_development_environment_section(software_system, java.io.File.new(documentationRoot, '10-development-environment.adoc'))
        template.add_operation_and_support_section(software_system, java.io.File.new(documentationRoot, '11-operation-and-support.adoc'))
        template.add_decision_log_section(software_system, java.io.File.new(documentationRoot, '12-decision-log.adoc'))
      end
    end
  end
end
