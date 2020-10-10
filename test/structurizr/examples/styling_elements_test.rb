# frozen_string_literal: true

###
# An example of how to style elements on diagrams.
#
# Source: https://github.com/structurizr/java/blob/3223f0110e0f3f0bb49b22ee43351b9b07ad3943/structurizr-examples/src/com/structurizr/example/StylingElements.java
# Updated at: 2017-07-15
module Structurizr
  module Examples
    class StylingElements < Minitest::Test
      attr_reader :styles

      def setup
        workspace = Workspace.new('Styling Elements', 'This is a model of my software system.')
        model = workspace.getModel

        user = model.addPerson('User', 'A user of my software system.')
        softwareSystem = model.addSoftwareSystem('Software System', 'My software system.')
        webApplication = softwareSystem.addContainer('Web Application', 'My web application.', 'Java and Spring MVC')
        database = softwareSystem.addContainer('Database', 'My database.', 'Relational database schema')
        database.addTags('Database')
        user.uses(webApplication, 'Uses', 'HTTPS')
        webApplication.uses(database, 'Reads from and writes to', 'JDBC')

        views = workspace.getViews
        containerView = views.createContainerView(softwareSystem, 'containers', 'An example of a container diagram.')
        containerView.addAllElements

        @styles = workspace.getViews.getConfiguration.getStyles
      end

      def test_example_one
        styles.addElementStyle(Tags::ELEMENT).background('#438dd5').color('#ffffff')
      end

      def test_example_two
        styles.addElementStyle(Tags::ELEMENT).color('#ffffff')
        styles.addElementStyle(Tags::PERSON).background('#08427b')
        styles.addElementStyle(Tags::CONTAINER).background('#438dd5')
      end

      def test_example_three
        styles.addElementStyle(Tags::ELEMENT).color('#ffffff')
        styles.addElementStyle(Tags::PERSON).background('#08427b').shape(Shape::Person)
        styles.addElementStyle(Tags::CONTAINER).background('#438dd5')
        styles.addElementStyle('Database').shape(Shape::Cylinder)
      end
    end
  end
end
