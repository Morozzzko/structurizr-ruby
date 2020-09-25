# frozen_string_literal: true

###
# This is an example of how to use the HTTP-based health checks feature.
#
# You can see the health checks running at https:##structurizr.com#share#39441#health
# Source: https://github.com/structurizr/java/blob/90d63149039bdb6dc025fcf9d67410d852f9a59f/structurizr-examples/src/com/structurizr/example/HttpHealthChecks.java
# Updated at: 2018-06-21
module Structurizr
  module Examples
    class HttpHealthChecks < Minitest::Test
      DATABASE_TAG = 'Database'

      def test_definition
        workspace = Workspace.new('HTTP-based health checks example', 'An example of how to use the HTTP-based health checks feature')
        model = workspace.getModel
        views = workspace.getViews

        structurizr = model.addSoftwareSystem('Structurizr', 'A publishing platform for software architecture diagrams and documentation based upon the C4 model.')
        webApplication = structurizr.addContainer('structurizr.com', 'Provides all of the server-side functionality of Structurizr, serving static and dynamic content to users.', 'Java and Spring MVC')
        database = structurizr.addContainer('Database', 'Stores information about users, workspaces, etc.', 'Relational Database Schema')
        database.addTags(DATABASE_TAG)
        webApplication.uses(database, 'Reads from and writes to', 'JDBC')

        amazonWebServices = model.addDeploymentNode('Amazon Web Services', '', 'us-east-1')
        pivotalWebServices = amazonWebServices.addDeploymentNode('Pivotal Web Services', 'Platform as a Service provider.', 'Cloud Foundry')
        liveWebApplication = pivotalWebServices.addDeploymentNode('www.structurizr.com', 'An open source Java EE web server.', 'Apache Tomcat')
                                               .add(webApplication)
        liveDatabaseInstance = amazonWebServices.addDeploymentNode('Amazon RDS', 'Database as a Service provider.', 'MySQL')
                                                .add(database)

        ## add health checks to the container instances, which return a simple HTTP 200 to say everything is okay
        liveWebApplication.addHealthCheck('Web Application is running', 'https:##www.structurizr.com#health')
        liveDatabaseInstance.addHealthCheck('Database is accessible from Web Application', 'https:##www.structurizr.com#health#database')

        ## the pass#fail status from the health checks is used to supplement any deployment views that include the container instances that have health checks defined
        deploymentView = views.createDeploymentView(structurizr, 'Deployment', 'A deployment diagram showing the live environment.')
        deploymentView.setEnvironment('Live')
        deploymentView.addAllDeploymentNodes

        views.getConfiguration.getStyles.addElementStyle(Tags.ELEMENT).color('#ffffff')
        views.getConfiguration.getStyles.addElementStyle(DATABASE_TAG).shape(Shape.Cylinder)
      end
    end
  end
end
