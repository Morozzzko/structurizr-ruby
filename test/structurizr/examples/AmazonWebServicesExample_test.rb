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
        model = workspace.getModel

        softwareSystem = model.addSoftwareSystem('Spring PetClinic', 'Allows employees to view and manage information regarding the veterinarians, the clients, and their pets.')
        webApplication = softwareSystem.addContainer('Web Application', 'Allows employees to view and manage information regarding the veterinarians, the clients, and their pets.', 'Java and Spring Boot')
        webApplication.addTags(SPRING_BOOT_TAG)
        database = softwareSystem.addContainer('Database', 'Stores information regarding the veterinarians, the clients, and their pets.', 'Relational database schema')
        database.addTags(DATABASE_TAG)

        webApplication.uses(database, 'Reads from and writes to', 'JDBC#SSL')

        amazonWebServices = model.addDeploymentNode('Amazon Web Services')
        amazonWebServices.addTags('Amazon Web Services - Cloud')
        amazonRegion = amazonWebServices.addDeploymentNode('US-East-1')
        amazonRegion.addTags('Amazon Web Services - Region')
        autoscalingGroup = amazonRegion.addDeploymentNode('Autoscaling group')
        autoscalingGroup.addTags('Amazon Web Services - Auto Scaling')
        ec2 = autoscalingGroup.addDeploymentNode('Amazon EC2')
        ec2.addTags('Amazon Web Services - EC2')
        webApplicationInstance = ec2.add(webApplication)

        route53 = amazonRegion.addInfrastructureNode('Route 53')
        route53.addTags('Amazon Web Services - Route 53')

        elb = amazonRegion.addInfrastructureNode('Elastic Load Balancer')
        elb.addTags('Amazon Web Services - Elastic Load Balancing')

        route53.uses(elb, 'Forwards requests to', 'HTTPS')
        elb.uses(webApplicationInstance, 'Forwards requests to', 'HTTPS')

        rds = amazonRegion.addDeploymentNode('Amazon RDS')
        rds.addTags('Amazon Web Services - RDS')
        mySql = rds.addDeploymentNode('MySQL')
        mySql.addTags('Amazon Web Services - RDS_MySQL_instance')
        databaseInstance = mySql.add(database)

        views = workspace.getViews
        deploymentView = views.createDeploymentView(softwareSystem, 'AmazonWebServicesDeployment', 'An example deployment diagram.')
        deploymentView.addAllDeploymentNodes

        deploymentView.addAnimation(route53)
        deploymentView.addAnimation(elb)
        deploymentView.addAnimation(webApplicationInstance)
        deploymentView.addAnimation(databaseInstance)

        styles = views.getConfiguration.getStyles
        styles.addElementStyle(SPRING_BOOT_TAG).shape(Shape.RoundedBox).background('#ffffff')
        styles.addElementStyle(DATABASE_TAG).shape(Shape.Cylinder).background('#ffffff')
        styles.addElementStyle(Tags.INFRASTRUCTURE_NODE).shape(Shape.RoundedBox).background('#ffffff')

        views.getConfiguration.setThemes('https:##raw.githubusercontent.com#structurizr#themes#master#amazon-web-services#theme.json')
      end
    end
  end
end
