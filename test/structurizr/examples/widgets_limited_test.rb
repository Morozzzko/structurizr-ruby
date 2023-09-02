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
        model = workspace.get_model
        views = workspace.get_views
        styles = views.get_configuration.get_styles

        model.set_enterprise(Enterprise.new('Widgets Limited'))

        customer = model.add_person(Location::External, 'Customer', 'A customer of Widgets Limited.')
        customerServiceUser = model.add_person(Location::Internal, 'Customer Service Agent', 'Deals with customer enquiries.')
        ecommerceSystem = model.add_software_system(Location::Internal, 'E-commerce System', 'Allows customers to buy widgets online via the widgets.com website.')
        fulfilmentSystem = model.add_software_system(Location::Internal, 'Fulfilment System', 'Responsible for processing and shipping of customer orders.')
        taxamo = model.add_software_system(Location::External, 'Taxamo', 'Calculates local tax (for EU B2B customers) and acts as a front-end for Braintree Payments.')
        taxamo.set_url('https://www.taxamo.com')
        braintreePayments = model.add_software_system(Location::External, 'Braintree Payments', 'Processes credit card payments on behalf of Widgets Limited.')
        braintreePayments.set_url('https://www.braintreepayments.com')
        jerseyPost = model.add_software_system(Location::External, 'Jersey Post', 'Calculates worldwide shipping costs for packages.')

        model.get_people.select do |relationship|
          relationship.get_location == Location::External
        end.each do |relationship|
          relationship.add_tags(EXTERNAL_TAG)
        end

        model.get_people.select do |relationship|
          relationship.get_location == Location::Internal
        end.each do |relationship|
          relationship.add_tags(INTERNAL_TAG)
        end

        model.get_software_systems.select do |relationship|
          relationship.get_location == Location::External
        end.each do |relationship|
          relationship.add_tags(EXTERNAL_TAG)
        end

        model.get_software_systems.select do |relationship|
          relationship.get_location == Location::Internal
        end.each do |relationship|
          relationship.add_tags(INTERNAL_TAG)
        end

        customer.interacts_with(customerServiceUser, 'Asks questions to', 'Telephone')
        customerServiceUser.uses(ecommerceSystem, 'Looks up order information using')
        customer.uses(ecommerceSystem, 'Places orders for widgets using')
        ecommerceSystem.uses(fulfilmentSystem, 'Sends order information to')
        fulfilmentSystem.uses(jerseyPost, 'Gets shipping charges from')
        ecommerceSystem.uses(taxamo, 'Delegates credit card processing to')
        taxamo.uses(braintreePayments, 'Uses for credit card processing')

        systemLandscapeView = views.create_system_landscape_view('SystemLandscape', 'The system landscape for Widgets Limited.')
        systemLandscapeView.add_all_elements

        ecommerceSystemContext = views.create_system_context_view(ecommerceSystem, 'EcommerceSystemContext', 'The system context diagram for the Widgets Limited e-commerce system.')
        ecommerceSystemContext.add_nearest_neighbours(ecommerceSystem)
        ecommerceSystemContext.remove(customer.get_efferent_relationship_with(customerServiceUser))

        fulfilmentSystemContext = views.create_system_context_view(fulfilmentSystem, 'FulfilmentSystemContext', 'The system context diagram for the Widgets Limited fulfilment system.')
        fulfilmentSystemContext.add_nearest_neighbours(fulfilmentSystem)

        dynamicView = views.create_dynamic_view('CustomerSupportCall', 'A high-level overview of the customer support call process.')
        dynamicView.add(customer, customerServiceUser)
        dynamicView.add(customerServiceUser, ecommerceSystem)

        styles.add_element_style(Tags::SOFTWARE_SYSTEM).shape(Shape::RoundedBox)
        styles.add_element_style(Tags::PERSON).shape(Shape::Person)

        styles.add_element_style(Tags::ELEMENT).color('#ffffff')
        styles.add_element_style(EXTERNAL_TAG).background('#EC5381').border(Border::Dashed)
        styles.add_element_style(INTERNAL_TAG).background('#B60037')
      end
    end
  end
end
