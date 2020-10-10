# frozen_string_literal: true

###
# This workspace contains a number of diagrams for a fictional reseller of widgets online.
#
# Source: https://github.com/structurizr/java/blob/9efb5b39ab2185aab4ea884495ada38c32c47f31/structurizr-examples/src/com/structurizr/example/WidgetsLimited.java
# Updated at: 2018-06-09
module Structurizr
  module Examples
    class WidgetsLimited < Minitest::Test
      EXTERNAL_TAG = 'External'
      INTERNAL_TAG = 'Internal'

      def test_definition
        workspace = Workspace.new('Widgets Limited', 'Sells widgets to customers online.')
        model = workspace.getModel
        views = workspace.getViews
        styles = views.getConfiguration.getStyles

        model.setEnterprise(Enterprise.new('Widgets Limited').to_java)

        customer = model.addPerson(Location::External, 'Customer', 'A customer of Widgets Limited.')
        customerServiceUser = model.addPerson(Location::Internal, 'Customer Service Agent', 'Deals with customer enquiries.')
        ecommerceSystem = model.addSoftwareSystem(Location::Internal, 'E-commerce System', 'Allows customers to buy widgets online via the widgets.com website.')
        fulfilmentSystem = model.addSoftwareSystem(Location::Internal, 'Fulfilment System', 'Responsible for processing and shipping of customer orders.')
        taxamo = model.addSoftwareSystem(Location::External, 'Taxamo', 'Calculates local tax (for EU B2B customers) and acts as a front-end for Braintree Payments.')
        taxamo.setUrl('https://www.taxamo.com')
        braintreePayments = model.addSoftwareSystem(Location::External, 'Braintree Payments', 'Processes credit card payments on behalf of Widgets Limited.')
        braintreePayments.setUrl('https://www.braintreepayments.com')
        jerseyPost = model.addSoftwareSystem(Location::External, 'Jersey Post', 'Calculates worldwide shipping costs for packages.')

        model.get_people.select do |relationship|
          relationship.get_location == Location::External
        end.each do |relationship|
          relationship.addTags(EXTERNAL_TAG)
        end

        model.get_people.select do |relationship|
          relationship.get_location == Location::Internal
        end.each do |relationship|
          relationship.addTags(INTERNAL_TAG)
        end

        model.get_software_systems.select do |relationship|
          relationship.get_location == Location::External
        end.each do |relationship|
          relationship.addTags(EXTERNAL_TAG)
        end

        model.get_software_systems.select do |relationship|
          relationship.get_location == Location::Internal
        end.each do |relationship|
          relationship.addTags(INTERNAL_TAG)
        end

        customer.interactsWith(customerServiceUser, 'Asks questions to', 'Telephone')
        customerServiceUser.uses(ecommerceSystem, 'Looks up order information using')
        customer.uses(ecommerceSystem, 'Places orders for widgets using')
        ecommerceSystem.uses(fulfilmentSystem, 'Sends order information to')
        fulfilmentSystem.uses(jerseyPost, 'Gets shipping charges from')
        ecommerceSystem.uses(taxamo, 'Delegates credit card processing to')
        taxamo.uses(braintreePayments, 'Uses for credit card processing')

        systemLandscapeView = views.createSystemLandscapeView('SystemLandscape', 'The system landscape for Widgets Limited.')
        systemLandscapeView.addAllElements

        ecommerceSystemContext = views.createSystemContextView(ecommerceSystem, 'EcommerceSystemContext', 'The system context diagram for the Widgets Limited e-commerce system.')
        ecommerceSystemContext.addNearestNeighbours(ecommerceSystem)
        ecommerceSystemContext.remove(customer.getEfferentRelationshipWith(customerServiceUser))

        fulfilmentSystemContext = views.createSystemContextView(fulfilmentSystem, 'FulfilmentSystemContext', 'The system context diagram for the Widgets Limited fulfilment system.')
        fulfilmentSystemContext.addNearestNeighbours(fulfilmentSystem)

        dynamicView = views.createDynamicView('CustomerSupportCall', 'A high-level overview of the customer support call process.')
        dynamicView.add(customer, customerServiceUser)
        dynamicView.add(customerServiceUser, ecommerceSystem)

        template = StructurizrDocumentationTemplate.new(workspace.to_java)
        template.addSection('System Landscape', Format::Markdown, 'Here is some information about the Widgets Limited system landscape... ![](embed:SystemLandscape)')
        template.addContextSection(ecommerceSystem, Format::Markdown, 'This is the context section for the E-commerce System... ![](embed:EcommerceSystemContext)')
        template.addContextSection(fulfilmentSystem, Format::Markdown, 'This is the context section for the Fulfilment System... ![](embed:FulfilmentSystemContext)')

        styles.addElementStyle(Tags::SOFTWARE_SYSTEM).shape(Shape::RoundedBox)
        styles.addElementStyle(Tags::PERSON).shape(Shape::Person)

        styles.addElementStyle(Tags::ELEMENT).color('#ffffff')
        styles.addElementStyle(EXTERNAL_TAG).background('#EC5381').border(Border::Dashed)
        styles.addElementStyle(INTERNAL_TAG).background('#B60037')
      end
    end
  end
end
