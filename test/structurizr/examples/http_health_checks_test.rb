# frozen_string_literal: true

###
# This is an example of how to use the HTTP-based health checks feature.
#
# Source: https://github.com/structurizr/java/blob/90d63149039bdb6dc025fcf9d67410d852f9a59f/structurizr-examples/src/com/structurizr/example/HttpHealthChecks.java
# Updated at: 2018-06-21
module Structurizr
  module Examples
    class HttpHealthChecks < Minitest::Test
      DATABASE_TAG = 'Database'

      def test_definition
        workspace = Workspace.new('HTTP-based health checks example', 'An example of how to use the HTTP-based health checks feature')
        model = workspace.get_model
        views = workspace.get_views

        structurizr = model.add_software_system('Structurizr', 'A publishing platform for software architecture diagrams and documentation based upon the C4 model.')
        webApplication = structurizr.add_container('structurizr.com', 'Provides all of the server-side functionality of Structurizr, serving static and dynamic content to users.', 'Java and Spring MVC')
        database = structurizr.add_container('Database', 'Stores information about users, workspaces, etc.', 'Relational Database Schema')
        database.add_tags(DATABASE_TAG)
        webApplication.uses(database, 'Reads from and writes to', 'JDBC')

        amazonWebServices = model.add_deployment_node('Amazon Web Services', '', 'us-east-1')
        pivotalWebServices = amazonWebServices.add_deployment_node('Pivotal Web Services', 'Platform as a Service provider.', 'Cloud Foundry')
        liveWebApplication = pivotalWebServices.add_deployment_node('www.structurizr.com', 'An open source Java EE web server.', 'Apache Tomcat')
                                               .add(webApplication)
        liveDatabaseInstance = amazonWebServices.add_deployment_node('Amazon RDS', 'Database as a Service provider.', 'MySQL')
                                                .add(database)

        ## add health checks to the container instances, which return a simple HTTP 200 to say everything is okay
        liveWebApplication.add_health_check('Web Application is running', 'https://www.structurizr.com/health')
        liveDatabaseInstance.add_health_check('Database is accessible from Web Application', 'https://www.structurizr.com/health/database')

        ## the pass#fail status from the health checks is used to supplement any deployment views that include the container instances that have health checks defined
        deploymentView = views.create_deployment_view(structurizr, 'Deployment', 'A deployment diagram showing the live environment.')
        deploymentView.set_environment('Live')
        deploymentView.add_all_deployment_nodes

        views.get_configuration.get_styles.add_element_style(Tags::ELEMENT).color('#ffffff')
        views.get_configuration.get_styles.add_element_style(DATABASE_TAG).shape(Shape::Cylinder)
      end
    end
  end
end
