# frozen_string_literal: true

###
# An empty software architecture document using the "Viewpoints and Perspectives" template.
#
# Source: https://github.com/structurizr/java/blob/e0db7582dc6dc7053ab995d7fff44c27d021312e/structurizr-examples/src/com/structurizr/example/ViewpointsAndPerspectivesDocumentationExample.java
# Updated at: 2017-07-25
module Structurizr
  module Examples
    class ViewpointsAndPerspectivesDocumentationExample < Minitest::Test
      attr_reader :template, :softwareSystem

      def setup
        workspace = Workspace.new('Documentation - Viewpoints and Perspectives', 'An empty software architecture document using the Viewpoints and Perspectives template.')
        model = workspace.get_model
        views = workspace.get_views

        user = model.add_person('User', 'A user of my software system.')
        @softwareSystem = model.add_software_system('Software System', 'My software system.')
        user.uses(software_system, 'Uses')

        contextView = views.create_system_context_view(software_system, 'SystemContext', 'An example of a System Context diagram.')
        contextView.add_all_software_systems
        contextView.add_all_people

        styles = views.get_configuration.get_styles
        styles.add_element_style(Tags::PERSON).shape(Shape::Person)

        @template = ViewpointsAndPerspectivesDocumentationTemplate.new(workspace.to_java)
      end

      def test_markdown
        documentationRoot = java.io.file.new(File.join(__dir__, 'documentation/viewpointsandperspectives/markdown'))
        template.add_introduction_section(software_system, java.io.file.new(documentationRoot, '01-introduction.md'))
        template.add_glossary_section(software_system, java.io.file.new(documentationRoot, '02-glossary.md'))
        template.add_system_stakeholders_and_requirements_section(software_system, java.io.file.new(documentationRoot, '03-system-stakeholders-and-requirements.md'))
        template.add_architectural_forces_section(software_system, java.io.file.new(documentationRoot, '04-architectural-forces.md'))
        template.add_architectural_views_section(software_system, java.io.file.new(documentationRoot, '05-architectural-views'))
        template.add_system_qualities_section(software_system, java.io.file.new(documentationRoot, '06-system-qualities.md'))
        template.add_appendices_section(software_system, java.io.file.new(documentationRoot, '07-appendices.md'))
      end

      def test_asciidoc
        documentationRoot = java.io.file.new(File.join(__dir__, 'documentation/viewpointsandperspectives/asciidoc'))
        template.add_introduction_section(software_system, java.io.file.new(documentationRoot, '01-introduction.adoc'))
        template.add_glossary_section(software_system, java.io.file.new(documentationRoot, '02-glossary.adoc'))
        template.add_system_stakeholders_and_requirements_section(software_system, java.io.file.new(documentationRoot, '03-system-stakeholders-and-requirements.adoc'))
        template.add_architectural_forces_section(software_system, java.io.file.new(documentationRoot, '04-architectural-forces.adoc'))
        template.add_architectural_views_section(software_system, java.io.file.new(documentationRoot, '05-architectural-views'))
        template.add_system_qualities_section(software_system, java.io.file.new(documentationRoot, '06-system-qualities.adoc'))
        template.add_appendices_section(software_system, java.io.file.new(documentationRoot, '07-appendices.adoc'))
      end
    end
  end
end
