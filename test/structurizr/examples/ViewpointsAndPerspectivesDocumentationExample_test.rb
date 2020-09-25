# frozen_string_literal: true

###
# An empty software architecture document using the "Viewpoints and Perspectives" template.
#
# See https:##structurizr.com#share#36371#documentation for the live version.
# Source: https://github.com/structurizr/java/blob/e0db7582dc6dc7053ab995d7fff44c27d021312e/structurizr-examples/src/com/structurizr/example/ViewpointsAndPerspectivesDocumentationExample.java
# Updated at: 2017-07-25
module Structurizr
  module Examples
    class ViewpointsAndPerspectivesDocumentationExample < Minitest::Test
      def test_definition
        workspace = Workspace.new('Documentation - Viewpoints and Perspectives', 'An empty software architecture document using the Viewpoints and Perspectives template.')
        model = workspace.getModel
        views = workspace.getViews

        user = model.addPerson('User', 'A user of my software system.')
        softwareSystem = model.addSoftwareSystem('Software System', 'My software system.')
        user.uses(softwareSystem, 'Uses')

        contextView = views.createSystemContextView(softwareSystem, 'SystemContext', 'An example of a System Context diagram.')
        contextView.addAllSoftwareSystems
        contextView.addAllPeople

        styles = views.getConfiguration.getStyles
        styles.addElementStyle(Tags.PERSON).shape(Shape.Person)

        template = ViewpointsAndPerspectivesDocumentationTemplate.new(workspace.to_java)

        ## this is the Markdown version
        documentationRoot = java.io.File.new(File.join(__dir__, 'documentation/viewpointsandperspectives/markdown'))
        template.addIntroductionSection(softwareSystem, java.io.File.new(documentationRoot, '01-introduction.md'))
        template.addGlossarySection(softwareSystem, java.io.File.new(documentationRoot, '02-glossary.md'))
        template.addSystemStakeholdersAndRequirementsSection(softwareSystem, java.io.File.new(documentationRoot, '03-system-stakeholders-and-requirements.md'))
        template.addArchitecturalForcesSection(softwareSystem, java.io.File.new(documentationRoot, '04-architectural-forces.md'))
        template.addArchitecturalViewsSection(softwareSystem, java.io.File.new(documentationRoot, '05-architectural-views'))
        template.addSystemQualitiesSection(softwareSystem, java.io.File.new(documentationRoot, '06-system-qualities.md'))
        template.addAppendicesSection(softwareSystem, java.io.File.new(documentationRoot, '07-appendices.md'))

        ## this is the AsciiDoc version
        ##        documentationRoot  = File.new(".#structurizr-examples#src#com#structurizr#example#documentation#viewpointsandperspectives#asciidoc");
        ##        template.addIntroductionSection(softwareSystem, File.new(documentationRoot, "01-introduction.adoc"));
        ##        template.addGlossarySection(softwareSystem, File.new(documentationRoot, "02-glossary.adoc"));
        ##        template.addSystemStakeholdersAndRequirementsSection(softwareSystem, File.new(documentationRoot, "03-system-stakeholders-and-requirements.adoc"));
        ##        template.addArchitecturalForcesSection(softwareSystem, File.new(documentationRoot, "04-architectural-forces.adoc"));
        ##        template.addArchitecturalViewsSection(softwareSystem, File.new(documentationRoot, "05-architectural-views"));
        ##        template.addSystemQualitiesSection(softwareSystem, File.new(documentationRoot, "06-system-qualities.adoc"));
        ##        template.addAppendicesSection(softwareSystem, File.new(documentationRoot, "07-appendices.adoc"));
      end
    end
  end
end
