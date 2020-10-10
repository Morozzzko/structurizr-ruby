# frozen_string_literal: true

###
# An example of how to style relationships on diagrams.
#
# Source: https://github.com/structurizr/java/blob/3223f0110e0f3f0bb49b22ee43351b9b07ad3943/structurizr-examples/src/com/structurizr/example/StylingRelationships.java
# Updated at: 2017-07-15
module Structurizr
  module Examples
    class StylingRelationships < Minitest::Test
      attr_reader :model, :styles

      def setup
        workspace = Workspace.new('Styling Relationships', 'This is a model of my software system.')
        @model = workspace.get_model

        user = model.add_person('User', 'A user of my software system.')
        softwareSystem = model.add_software_system('Software System', 'My software system.')
        webApplication = softwareSystem.add_container('Web Application', 'My web application.', 'Java and Spring MVC')
        database = softwareSystem.add_container('Database', 'My database.', 'Relational database schema')
        user.uses(webApplication, 'Uses', 'HTTPS')
        webApplication.uses(database, 'Reads from and writes to', 'JDBC')

        views = workspace.get_views
        containerView = views.create_container_view(softwareSystem, 'containers', 'An example of a container diagram.')
        containerView.add_all_elements

        @styles = workspace.get_views.get_configuration.get_styles
      end

      def test_example_one
        @styles.add_relationship_style(Tags::RELATIONSHIP).color('#ff0000')
      end

      def test_example_two
        @model.get_relationships.select do |relationship|
          relationship.get_technology == 'HTTPS'
        end.each do |relationship|
          relationship.add_tags('HTTPS')
        end

        @model.get_relationships.select do |relationship|
          relationship.get_technology == 'JDBC'
        end.each do |relationship|
          relationship.add_tags('JDBC')
        end
      end
    end
  end
end
