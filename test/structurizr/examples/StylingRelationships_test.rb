# frozen_string_literal: true

###
# An example of how to style relationships on diagrams.
#
# The live workspace is available to view at https:##structurizr.com#share#36131
# Source: https://github.com/structurizr/java/blob/3223f0110e0f3f0bb49b22ee43351b9b07ad3943/structurizr-examples/src/com/structurizr/example/StylingRelationships.java
# Updated at: 2017-07-15
module Structurizr
  module Examples
    class StylingRelationships < Minitest::Test
      def test_definition
        workspace = Workspace.new('Styling Relationships', 'This is a model of my software system.')
        model = workspace.getModel

        user = model.addPerson('User', 'A user of my software system.')
        softwareSystem = model.addSoftwareSystem('Software System', 'My software system.')
        webApplication = softwareSystem.addContainer('Web Application', 'My web application.', 'Java and Spring MVC')
        database = softwareSystem.addContainer('Database', 'My database.', 'Relational database schema')
        user.uses(webApplication, 'Uses', 'HTTPS')
        webApplication.uses(database, 'Reads from and writes to', 'JDBC')

        views = workspace.getViews
        containerView = views.createContainerView(softwareSystem, 'containers', 'An example of a container diagram.')
        containerView.addAllElements

        styles = workspace.getViews.getConfiguration.getStyles

        ## example 1
        ##        styles.addRelationshipStyle(Tags.RELATIONSHIP).color("#ff0000");

        ## example 2
        # ##        model.getRelationships().stream().filter(r -> "HTTPS".equals(r.getTechnology())).forEach(r -> r.addTags("HTTPS")); # TODO: rewrite to Ruby arrays
        # ##        model.getRelationships().stream().filter(r -> "JDBC".equals(r.getTechnology())).forEach(r -> r.addTags("JDBC")); # TODO: rewrite to Ruby arrays
        ##        styles.addRelationshipStyle("HTTPS").color("#ff0000");
        ##        styles.addRelationshipStyle("JDBC").color("#0000ff");
      end
    end
  end
end
