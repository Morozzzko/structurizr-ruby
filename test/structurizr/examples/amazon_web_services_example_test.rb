# frozen_string_literal: true

###
# An example of how to document an AWS deployment.
#
# Source: https://github.com/structurizr/java/blob/5efbb57021f25fb463d65791e4cd52361b25106d/structurizr-examples/src/com/structurizr/example/AmazonWebServicesExample.java
# Updated at: 2020-05-28
module Structurizr
  module Examples
    class AmazonWebServicesExample < Minitest::Test
      SPRING_BOOT_TAG = 'Spring Boot Application'
      DATABASE_TAG = 'Database'

      def test_definition
        workspace = Workspace.new('Amazon Web Services Example', 'An example AWS deployment architecture.')
        model = workspace.get_model

        softwareSystem = model.add_software_system('Spring PetClinic', 'Allows employees to view and manage information regarding the veterinarians, the clients, and their pets.')
        webApplication = softwareSystem.add_container('Web Application', 'Allows employees to view and manage information regarding the veterinarians, the clients, and their pets.', 'Java and Spring Boot')
        webApplication.add_tags(SPRING_BOOT_TAG)
        database = softwareSystem.add_container('Database', 'Stores information regarding the veterinarians, the clients, and their pets.', 'Relational database schema')
        database.add_tags(DATABASE_TAG)

        webApplication.uses(database, 'Reads from and writes to', 'JDBC#SSL')

        amazonWebServices = model.add_deployment_node('Amazon Web Services')
        amazonWebServices.add_tags('Amazon Web Services - Cloud')
        amazonRegion = amazonWebServices.add_deployment_node('US-East-1')
        amazonRegion.add_tags('Amazon Web Services - Region')
        autoscalingGroup = amazonRegion.add_deployment_node('Autoscaling group')
        autoscalingGroup.add_tags('Amazon Web Services - Auto Scaling')
        ec2 = autoscalingGroup.add_deployment_node('Amazon EC2')
        ec2.add_tags('Amazon Web Services - EC2')
        webApplicationInstance = ec2.add(webApplication)

        route53 = amazonRegion.add_infrastructure_node('Route 53')
        route53.add_tags('Amazon Web Services - Route 53')

        elb = amazonRegion.add_infrastructure_node('Elastic Load Balancer')
        elb.add_tags('Amazon Web Services - Elastic Load Balancing')

        route53.uses(elb, 'Forwards requests to', 'HTTPS')
        elb.uses(webApplicationInstance, 'Forwards requests to', 'HTTPS')

        rds = amazonRegion.add_deployment_node('Amazon RDS')
        rds.add_tags('Amazon Web Services - RDS')
        mySql = rds.add_deployment_node('MySQL')
        mySql.add_tags('Amazon Web Services - RDS_MySQL_instance')
        databaseInstance = mySql.add(database)

        views = workspace.get_views
        deploymentView = views.create_deployment_view(softwareSystem, 'AmazonWebServicesDeployment', 'An example deployment diagram.')
        deploymentView.add_all_deployment_nodes

        deploymentView.add_animation(route53)
        deploymentView.add_animation(elb)
        deploymentView.add_animation(webApplicationInstance)
        deploymentView.add_animation(databaseInstance)

        styles = views.get_configuration.get_styles
        styles.add_element_style(SPRING_BOOT_TAG).shape(Shape::RoundedBox).background('#ffffff')
        styles.add_element_style(DATABASE_TAG).shape(Shape::Cylinder).background('#ffffff')
        styles.add_element_style(Tags::INFRASTRUCTURE_NODE).shape(Shape::RoundedBox).background('#ffffff')

        views.get_configuration.set_themes('https://raw.githubusercontent.com/structurizr/themes/master/amazon-web-services/theme.json')
      end
    end
  end
end
