# frozen_string_literal: true

require 'test_helper'

# https://github.com/structurizr/java/blob/master/structurizr-examples/src/com/structurizr/example/FinancialRiskSystem.java
module Structurizr
  module Examples
    class FinancialRiskSystemTest < Minitest::Test
      TAG_ALERT = 'Alert'

      def test_definition
        workspace = Workspace.new(
          'Financial Risk System',
          'This is a simple (incomplete) example C4 model based upon the financial risk system architecture kata, which can be found at http://bit.ly/sa4d-risksystem'
        )

        model = workspace.getModel

        financialRiskSystem = model.addSoftwareSystem('Financial Risk System', "Calculates the bank's exposure to risk for product X.")

        businessUser = model.addPerson('Business User', 'A regular business user.')
        businessUser.uses(financialRiskSystem, 'Views reports using')

        configurationUser = model.addPerson('Configuration User', 'A regular business user who can also configure the parameters used in the risk calculations.')
        configurationUser.uses(financialRiskSystem, 'Configures parameters using')

        tradeDataSystem = model.addSoftwareSystem('Trade Data System', 'The system of record for trades of type X.')
        financialRiskSystem.uses(tradeDataSystem, 'Gets trade data from')

        referenceDataSystem = model.addSoftwareSystem('Reference Data System', 'Manages reference data for all counterparties the bank interacts with.')
        financialRiskSystem.uses(referenceDataSystem, 'Gets counterparty data from')

        referenceDataSystemV2 = model.addSoftwareSystem('Reference Data System v2.0', 'Manages reference data for all counterparties the bank interacts with.')
        financialRiskSystem.uses(referenceDataSystemV2, 'Gets counterparty data from')

        emailSystem = model.addSoftwareSystem('E-mail system', "The bank's Microsoft Exchange system.")
        financialRiskSystem.uses(emailSystem, 'Sends a notification that a report is ready to')
        emailSystem.delivers(businessUser, 'Sends a notification that a report is ready to', 'E-mail message', InteractionStyle.Asynchronous)

        centralMonitoringService = model.addSoftwareSystem('Central Monitoring Service', "The bank's central monitoring and alerting dashboard.")
        financialRiskSystem.uses(centralMonitoringService, 'Sends critical failure alerts to', 'SNMP', InteractionStyle.Asynchronous)

        activeDirectory = model.addSoftwareSystem('Active Directory', "The bank's authentication and authorisation system.")
        financialRiskSystem.uses(activeDirectory, 'Uses for user authentication and authorisation')

        refute_nil workspace
      end
    end
  end
end
