# frozen_string_literal: true

###
# An empty software architecture document based upon the Structurizr template,
# created with the automatic document template.
#
# Source: https://github.com/structurizr/java/blob/829738a1c7fea2e786239958a891599135c0d906/structurizr-examples/src/com/structurizr/example/AutomaticDocumentationTemplateExample.java
# Updated at: 2017-07-23
module Structurizr
  module Examples
    class AutomaticDocumentationTemplateExample < Minitest::Test
      def test_definition
        workspace = Workspace.new('Documentation - Automatic', 'An empty software architecture document using the Structurizr template.')
        model = workspace.getModel
        views = workspace.getViews

        user = model.addPerson('User', 'A user of my software system.')
        softwareSystem = model.addSoftwareSystem('Software System', 'My software system.')
        user.uses(softwareSystem, 'Uses')

        contextView = views.createSystemContextView(softwareSystem, 'SystemContext', 'An example of a System Context diagram.')
        contextView.addAllSoftwareSystems
        contextView.addAllPeople

        styles = views.getConfiguration.getStyles
        styles.addElementStyle(Tags::PERSON).shape(Shape::Person)

        ## this directory includes a mix of Markdown and AsciiDoc files
        documentationRoot = java.io.File.new(File.join(__dir__, 'documentation/automatic'))

        template = AutomaticDocumentationTemplate.new(workspace.to_java)
        template.addSections(softwareSystem, documentationRoot)
      end
    end
  end
end
