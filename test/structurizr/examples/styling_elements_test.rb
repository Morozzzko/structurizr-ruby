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
        model = workspace.get_model

        user = model.add_person('User', 'A user of my software system.')
        softwareSystem = model.add_software_system('Software System', 'My software system.')
        webApplication = softwareSystem.add_container('Web Application', 'My web application.', 'Java and Spring MVC')
        database = softwareSystem.add_container('Database', 'My database.', 'Relational database schema')
        database.add_tags('Database')
        user.uses(webApplication, 'Uses', 'HTTPS')
        webApplication.uses(database, 'Reads from and writes to', 'JDBC')

        views = workspace.get_views
        containerView = views.create_container_view(softwareSystem, 'containers', 'An example of a container diagram.')
        containerView.add_all_elements

        @styles = workspace.get_views.get_configuration.get_styles
      end

      def test_example_one
        styles.add_element_style(Tags::ELEMENT).background('#438dd5').color('#ffffff')
      end

      def test_example_two
        styles.add_element_style(Tags::ELEMENT).color('#ffffff')
        styles.add_element_style(Tags::PERSON).background('#08427b')
        styles.add_element_style(Tags::CONTAINER).background('#438dd5')
      end

      def test_example_three
        styles.add_element_style(Tags::ELEMENT).color('#ffffff')
        styles.add_element_style(Tags::PERSON).background('#08427b').shape(Shape::Person)
        styles.add_element_style(Tags::CONTAINER).background('#438dd5')
        styles.add_element_style('Database').shape(Shape::Cylinder)
      end
    end
  end
end
