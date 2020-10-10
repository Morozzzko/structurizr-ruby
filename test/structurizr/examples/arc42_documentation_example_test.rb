# frozen_string_literal: true

###
# An empty software architecture document using the arc42 template.
#
# Source: https://github.com/structurizr/java/blob/e0db7582dc6dc7053ab995d7fff44c27d021312e/structurizr-examples/src/com/structurizr/example/Arc42DocumentationExample.java
# Updated at: 2017-07-25
module Structurizr
  module Examples
    class Arc42DocumentationExample < Minitest::Test
      attr_reader :template, :software_system

      def setup
        workspace = Workspace.new('Documentation - arc42', 'An empty software architecture document using the arc42 template.')
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

        @template = Arc42DocumentationTemplate.new(workspace.to_java)
      end

      def test_markdown
        documentationRoot = File.join(__dir__, 'documentation/arc42/markdown')
        template.add_introduction_and_goals_section(software_system, java.io.File.new(File.join(documentationRoot, '01-introduction-and-goals.md')))
        template.add_constraints_section(software_system, java.io.File.new(File.join(documentationRoot, '02-architecture-constraints.md')))
        template.add_context_and_scope_section(software_system, java.io.File.new(File.join(documentationRoot, '03-system-scope-and-context.md')))
        template.add_solution_strategy_section(software_system, java.io.File.new(File.join(documentationRoot, '04-solution-strategy.md')))
        template.add_building_block_view_section(software_system, java.io.File.new(File.join(documentationRoot, '05-building-block-view.md')))
        template.add_runtime_view_section(software_system, java.io.File.new(File.join(documentationRoot, '06-runtime-view.md')))
        template.add_deployment_view_section(software_system, java.io.File.new(File.join(documentationRoot, '07-deployment-view.md')))
        template.add_crosscutting_concepts_section(software_system, java.io.File.new(File.join(documentationRoot, '08-crosscutting-concepts.md')))
        template.add_architectural_decisions_section(software_system, java.io.File.new(File.join(documentationRoot, '09-architecture-decisions.md')))
        template.add_risks_and_technical_debt_section(software_system, java.io.File.new(File.join(documentationRoot, '10-quality-requirements.md')))
        template.add_quality_requirements_section(software_system, java.io.File.new(File.join(documentationRoot, '11-risks-and-technical-debt.md')))
        template.add_glossary_section(software_system, java.io.File.new(File.join(documentationRoot, '12-glossary.md')))
      end

      def test_asciidoc
        documentationRoot = File.join(__dir__, 'documentation/arc42/asciidoc')
        template.add_introduction_and_goals_section(software_system, java.io.File.new(File.join(documentationRoot, '01-introduction-and-goals.adoc')))
        template.add_constraints_section(software_system, java.io.File.new(File.join(documentationRoot, '02-architecture-constraints.adoc')))
        template.add_context_and_scope_section(software_system, java.io.File.new(File.join(documentationRoot, '03-system-scope-and-context.adoc')))
        template.add_solution_strategy_section(software_system, java.io.File.new(File.join(documentationRoot, '04-solution-strategy.adoc')))
        template.add_building_block_view_section(software_system, java.io.File.new(File.join(documentationRoot, '05-building-block-view.adoc')))
        template.add_runtime_view_section(software_system, java.io.File.new(File.join(documentationRoot, '06-runtime-view.adoc')))
        template.add_deployment_view_section(software_system, java.io.File.new(File.join(documentationRoot, '07-deployment-view.adoc')))
        template.add_crosscutting_concepts_section(software_system, java.io.File.new(File.join(documentationRoot, '08-crosscutting-concepts.adoc')))
        template.add_architectural_decisions_section(software_system, java.io.File.new(File.join(documentationRoot, '09-architecture-decisions.adoc')))
        template.add_risks_and_technical_debt_section(software_system, java.io.File.new(File.join(documentationRoot, '10-quality-requirements.adoc')))
        template.add_quality_requirements_section(software_system, java.io.File.new(File.join(documentationRoot, '11-risks-and-technical-debt.adoc')))
        template.add_glossary_section(software_system, java.io.File.new(File.join(documentationRoot, '12-glossary.adoc')))
      end
    end
  end
end
