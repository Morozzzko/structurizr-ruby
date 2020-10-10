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
        model = workspace.get_model

        mySoftwareSystem = model.add_software_system('Customer Information System', 'Stores information ')
        customer = model.add_person('Customer', 'A customer')
        customerApplication = mySoftwareSystem.add_container('Customer Application', 'Allows customers to manage their profile.', 'Angular')

        customerService = mySoftwareSystem.add_container('Customer Service', 'The point of access for customer information.', 'Java and Spring Boot')
        customerService.add_tags(MICROSERVICE_TAG)
        customerDatabase = mySoftwareSystem.add_container('Customer Database', 'Stores customer information.', 'Oracle 12c')
        customerDatabase.add_tags(DATASTORE_TAG)

        reportingService = mySoftwareSystem.add_container('Reporting Service', 'Creates normalised data for reporting purposes.', 'Ruby')
        reportingService.add_tags(MICROSERVICE_TAG)
        reportingDatabase = mySoftwareSystem.add_container('Reporting Database', 'Stores a normalised version of all business data for ad hoc reporting purposes.', 'MySQL')
        reportingDatabase.add_tags(DATASTORE_TAG)

        auditService = mySoftwareSystem.add_container('Audit Service', 'Provides organisation-wide auditing facilities.', 'C# .NET')
        auditService.add_tags(MICROSERVICE_TAG)
        auditStore = mySoftwareSystem.add_container('Audit Store', 'Stores information about events that have happened.', 'Event Store')
        auditStore.add_tags(DATASTORE_TAG)

        messageBus = mySoftwareSystem.add_container('Message Bus', 'Transport for business events.', 'RabbitMQ')
        messageBus.add_tags(MESSAGE_BUS_TAG)

        customer.uses(customerApplication, 'Uses')
        customerApplication.uses(customerService, 'Updates customer information using', 'JSON#HTTPS', InteractionStyle::Synchronous)
        customerService.uses(messageBus, 'Sends customer update events to', '', InteractionStyle::Asynchronous)
        customerService.uses(customerDatabase, 'Stores data in', 'JDBC', InteractionStyle::Synchronous)
        customerService.uses(customerApplication, 'Sends events to', 'WebSocket', InteractionStyle::Asynchronous)
        messageBus.uses(reportingService, 'Sends customer update events to', '', InteractionStyle::Asynchronous)
        messageBus.uses(auditService, 'Sends customer update events to', '', InteractionStyle::Asynchronous)
        reportingService.uses(reportingDatabase, 'Stores data in', '', InteractionStyle::Synchronous)
        auditService.uses(auditStore, 'Stores events in', '', InteractionStyle::Synchronous)

        views = workspace.get_views

        containerView = views.create_container_view(mySoftwareSystem, 'Containers', nil)
        containerView.add_all_elements

        dynamicView = views.create_dynamic_view(mySoftwareSystem, 'CustomerUpdateEvent', 'This diagram shows what happens when a customer updates their details.')
        dynamicView.add(customer, customerApplication)
        dynamicView.add(customerApplication, customerService)

        dynamicView.add(customerService, customerDatabase)
        dynamicView.add(customerService, messageBus)

        dynamicView.start_parallel_sequence
        dynamicView.add(messageBus, reportingService)
        dynamicView.add(reportingService, reportingDatabase)
        dynamicView.end_parallel_sequence

        dynamicView.start_parallel_sequence
        dynamicView.add(messageBus, auditService)
        dynamicView.add(auditService, auditStore)
        dynamicView.end_parallel_sequence

        dynamicView.start_parallel_sequence
        dynamicView.add(customerService, 'Confirms update to', customerApplication)
        dynamicView.end_parallel_sequence

        styles = views.get_configuration.get_styles
        styles.add_element_style(Tags::ELEMENT).color('#000000')
        styles.add_element_style(Tags::PERSON).background('#ffbf00').shape(Shape::Person)
        styles.add_element_style(Tags::CONTAINER).background('#facc2E')
        styles.add_element_style(MESSAGE_BUS_TAG).width(1600).shape(Shape::Pipe)
        styles.add_element_style(MICROSERVICE_TAG).shape(Shape::Hexagon)
        styles.add_element_style(DATASTORE_TAG).background('#f5da81').shape(Shape::Cylinder)
        styles.add_relationship_style(Tags::RELATIONSHIP).routing(Routing::Orthogonal)

        styles.add_relationship_style(Tags::ASYNCHRONOUS).dashed(true)
        styles.add_relationship_style(Tags::SYNCHRONOUS).dashed(false)
      end
    end
  end
end
