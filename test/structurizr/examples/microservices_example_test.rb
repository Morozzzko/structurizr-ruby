# frozen_string_literal: true

###
# A simple example of what a microservices architecture might look like. This workspace also
# includes a dynamic view that demonstrates parallel sequences of events.
#
# Source: https://github.com/structurizr/java/blob/de69976fcef04db6afceea2d9c98842d2d8c5736/structurizr-examples/src/com/structurizr/example/MicroservicesExample.java
# Updated at: 2018-08-07
module Structurizr
  module Examples
    class MicroservicesExample < Minitest::Test
      MICROSERVICE_TAG = 'Microservice'
      MESSAGE_BUS_TAG = 'Message Bus'
      DATASTORE_TAG = 'Database'

      def test_definition
        workspace = Workspace.new('Microservices example', 'An example of a microservices architecture, which includes asynchronous and parallel behaviour.')
        model = workspace.getModel

        mySoftwareSystem = model.addSoftwareSystem('Customer Information System', 'Stores information ')
        customer = model.addPerson('Customer', 'A customer')
        customerApplication = mySoftwareSystem.addContainer('Customer Application', 'Allows customers to manage their profile.', 'Angular')

        customerService = mySoftwareSystem.addContainer('Customer Service', 'The point of access for customer information.', 'Java and Spring Boot')
        customerService.addTags(MICROSERVICE_TAG)
        customerDatabase = mySoftwareSystem.addContainer('Customer Database', 'Stores customer information.', 'Oracle 12c')
        customerDatabase.addTags(DATASTORE_TAG)

        reportingService = mySoftwareSystem.addContainer('Reporting Service', 'Creates normalised data for reporting purposes.', 'Ruby')
        reportingService.addTags(MICROSERVICE_TAG)
        reportingDatabase = mySoftwareSystem.addContainer('Reporting Database', 'Stores a normalised version of all business data for ad hoc reporting purposes.', 'MySQL')
        reportingDatabase.addTags(DATASTORE_TAG)

        auditService = mySoftwareSystem.addContainer('Audit Service', 'Provides organisation-wide auditing facilities.', 'C# .NET')
        auditService.addTags(MICROSERVICE_TAG)
        auditStore = mySoftwareSystem.addContainer('Audit Store', 'Stores information about events that have happened.', 'Event Store')
        auditStore.addTags(DATASTORE_TAG)

        messageBus = mySoftwareSystem.addContainer('Message Bus', 'Transport for business events.', 'RabbitMQ')
        messageBus.addTags(MESSAGE_BUS_TAG)

        customer.uses(customerApplication, 'Uses')
        customerApplication.uses(customerService, 'Updates customer information using', 'JSON#HTTPS', InteractionStyle.Synchronous)
        customerService.uses(messageBus, 'Sends customer update events to', '', InteractionStyle.Asynchronous)
        customerService.uses(customerDatabase, 'Stores data in', 'JDBC', InteractionStyle.Synchronous)
        customerService.uses(customerApplication, 'Sends events to', 'WebSocket', InteractionStyle.Asynchronous)
        messageBus.uses(reportingService, 'Sends customer update events to', '', InteractionStyle.Asynchronous)
        messageBus.uses(auditService, 'Sends customer update events to', '', InteractionStyle.Asynchronous)
        reportingService.uses(reportingDatabase, 'Stores data in', '', InteractionStyle.Synchronous)
        auditService.uses(auditStore, 'Stores events in', '', InteractionStyle.Synchronous)

        views = workspace.getViews

        containerView = views.createContainerView(mySoftwareSystem, 'Containers', nil)
        containerView.addAllElements

        dynamicView = views.createDynamicView(mySoftwareSystem, 'CustomerUpdateEvent', 'This diagram shows what happens when a customer updates their details.')
        dynamicView.add(customer, customerApplication)
        dynamicView.add(customerApplication, customerService)

        dynamicView.add(customerService, customerDatabase)
        dynamicView.add(customerService, messageBus)

        dynamicView.startParallelSequence
        dynamicView.add(messageBus, reportingService)
        dynamicView.add(reportingService, reportingDatabase)
        dynamicView.endParallelSequence

        dynamicView.startParallelSequence
        dynamicView.add(messageBus, auditService)
        dynamicView.add(auditService, auditStore)
        dynamicView.endParallelSequence

        dynamicView.startParallelSequence
        dynamicView.add(customerService, 'Confirms update to', customerApplication)
        dynamicView.endParallelSequence

        styles = views.getConfiguration.getStyles
        styles.addElementStyle(Tags.ELEMENT).color('#000000')
        styles.addElementStyle(Tags.PERSON).background('#ffbf00').shape(Shape.Person)
        styles.addElementStyle(Tags.CONTAINER).background('#facc2E')
        styles.addElementStyle(MESSAGE_BUS_TAG).width(1600).shape(Shape.Pipe)
        styles.addElementStyle(MICROSERVICE_TAG).shape(Shape.Hexagon)
        styles.addElementStyle(DATASTORE_TAG).background('#f5da81').shape(Shape.Cylinder)
        styles.addRelationshipStyle(Tags.RELATIONSHIP).routing(Routing.Orthogonal)

        styles.addRelationshipStyle(Tags.ASYNCHRONOUS).dashed(true)
        styles.addRelationshipStyle(Tags.SYNCHRONOUS).dashed(false)
      end
    end
  end
end
