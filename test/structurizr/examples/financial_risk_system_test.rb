# frozen_string_literal: true

###
# This is a simple (incomplete) example C4 model based upon the financial risk system
# architecture kata, which can be found at http://bit.ly/sa4d-risksystem
#
# Source: https://github.com/structurizr/java/blob/829738a1c7fea2e786239958a891599135c0d906/structurizr-examples/src/com/structurizr/example/FinancialRiskSystem.java
# Updated at: 2017-07-23
module Structurizr
  module Examples
    class FinancialRiskSystem < Minitest::Test
      TAG_ALERT = 'Alert'

      def test_definition
        workspace = Workspace.new('Financial Risk System', 'This is a simple (incomplete) example C4 model based upon the financial risk system architecture kata, which can be found at http://bit.ly/sa4d-risksystem')
        model = workspace.get_model

        financialRiskSystem = model.add_software_system('Financial Risk System', "Calculates the bank's exposure to risk for product X.")

        businessUser = model.add_person('Business User', 'A regular business user.')
        businessUser.uses(financialRiskSystem, 'Views reports using')

        configurationUser = model.add_person('Configuration User', 'A regular business user who can also configure the parameters used in the risk calculations.')
        configurationUser.uses(financialRiskSystem, 'Configures parameters using')

        tradeDataSystem = model.add_software_system('Trade Data System', 'The system of record for trades of type X.')
        financialRiskSystem.uses(tradeDataSystem, 'Gets trade data from')

        referenceDataSystem = model.add_software_system('Reference Data System', 'Manages reference data for all counterparties the bank interacts with.')
        financialRiskSystem.uses(referenceDataSystem, 'Gets counterparty data from')

        referenceDataSystemV2 = model.add_software_system('Reference Data System v2.0', 'Manages reference data for all counterparties the bank interacts with.')
        referenceDataSystemV2.add_tags('Future State')
        financialRiskSystem.uses(referenceDataSystemV2, 'Gets counterparty data from').add_tags('Future State')

        emailSystem = model.add_software_system('E-mail system', "The bank's Microsoft Exchange system.")
        financialRiskSystem.uses(emailSystem, 'Sends a notification that a report is ready to')
        emailSystem.delivers(businessUser, 'Sends a notification that a report is ready to', 'E-mail message', InteractionStyle::Asynchronous)

        centralMonitoringService = model.add_software_system('Central Monitoring Service', "The bank's central monitoring and alerting dashboard.")
        financialRiskSystem.uses(centralMonitoringService, 'Sends critical failure alerts to', 'SNMP', InteractionStyle::Asynchronous).add_tags(TAG_ALERT)

        activeDirectory = model.add_software_system('Active Directory', "The bank's authentication and authorisation system.")
        financialRiskSystem.uses(activeDirectory, 'Uses for user authentication and authorisation')

        views = workspace.get_views
        contextView = views.create_system_context_view(financialRiskSystem, 'Context', 'An example System Context diagram for the Financial Risk System architecture kata.')
        contextView.add_all_software_systems
        contextView.add_all_people

        styles = views.get_configuration.get_styles
        financialRiskSystem.add_tags('Risk System')

        styles.add_element_style(Tags::ELEMENT).color('#ffffff').font_size(34)
        styles.add_element_style('Risk System').background('#550000').color('#ffffff')
        styles.add_element_style(Tags::SOFTWARE_SYSTEM).width(650).height(400).background('#801515').shape(Shape::RoundedBox)
        styles.add_element_style(Tags::PERSON).width(550).background('#d46a6a').shape(Shape::Person)

        styles.add_relationship_style(Tags::RELATIONSHIP).thickness(4).dashed(false).font_size(32).width(400)
        styles.add_relationship_style(Tags::SYNCHRONOUS).dashed(false)
        styles.add_relationship_style(Tags::ASYNCHRONOUS).dashed(true)
        styles.add_relationship_style(TAG_ALERT).color('#ff0000')

        styles.add_element_style('Future State').opacity(30).border(Border::Dashed)
        styles.add_relationship_style('Future State').opacity(30).dashed(true)

        template = StructurizrDocumentationTemplate.new(workspace)
        documentationRoot = java.io.File.new(File.join(__dir__, 'financialrisksystem'))
        template.add_context_section(financialRiskSystem, java.io.File.new(documentationRoot, 'context.adoc'))
        template.add_functional_overview_section(financialRiskSystem, java.io.File.new(documentationRoot, 'functional-overview.md'))
        template.add_quality_attributes_section(financialRiskSystem, java.io.File.new(documentationRoot, 'quality-attributes.md'))
        template.add_images(documentationRoot)
      end
    end
  end
end
