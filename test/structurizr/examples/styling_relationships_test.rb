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
        @model = workspace.getModel

        user = model.addPerson('User', 'A user of my software system.')
        softwareSystem = model.addSoftwareSystem('Software System', 'My software system.')
        webApplication = softwareSystem.addContainer('Web Application', 'My web application.', 'Java and Spring MVC')
        database = softwareSystem.addContainer('Database', 'My database.', 'Relational database schema')
        user.uses(webApplication, 'Uses', 'HTTPS')
        webApplication.uses(database, 'Reads from and writes to', 'JDBC')

        views = workspace.getViews
        containerView = views.createContainerView(softwareSystem, 'containers', 'An example of a container diagram.')
        containerView.addAllElements

        @styles = workspace.getViews.getConfiguration.getStyles
      end

      def test_example_one
        @styles.addRelationshipStyle(Tags::RELATIONSHIP).color('#ff0000')
      end

      def test_example_two
        @model.get_relationships.select do |relationship|
          relationship.get_technology == 'HTTPS'
        end.each do |relationship|
          relationship.addTags('HTTPS')
        end

        @model.get_relationships.select do |relationship|
          relationship.get_technology == 'JDBC'
        end.each do |relationship|
          relationship.addTags('JDBC')
        end
      end
    end
  end
end
