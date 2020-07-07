# frozen_string_literal: true

require 'test_helper'

# https://github.com/structurizr/java/blob/master/structurizr-examples/src/com/structurizr/example/BigBankPlc.java
module Structurizr
  module Examples
    class BingBankPlcTest < Minitest::Test
      EXISTING_SYSTEM_TAG = 'Existing System'
      BANK_STAFF_TAG = 'Bank Staff'
      WEB_BROWSER_TAG = 'Web Browser'
      MOBILE_APP_TAG = 'Mobile App'
      DATABASE_TAG = 'Database'
      FAILOVER_TAG = 'Failover'

      def test_definition
        workspace = Workspace.new(
          'Big Bank plc',
          'This is an example workspace to illustrate the key features of Structurizr, based around a fictional online banking system.'
        )
        model = workspace.getModel
        model.setImpliedRelationshipsStrategy(::Structurizr::Metal::Model::CreateImpliedRelationshipsUnlessAnyRelationshipExistsStrategy.new)
        views = workspace.getViews

        model.setEnterprise(Enterprise.new('Big Bank plc').to_java)

        # people and software systems
        customer = model.addPerson(Location.External, 'Personal Banking Customer', 'A customer of the bank, with personal bank accounts.')

        internetBankingSystem = model.addSoftwareSystem(Location.Internal, 'Internet Banking System', 'Allows customers to view information about their bank accounts, and make payments.')
        customer.uses(internetBankingSystem, 'Views account balances, and makes payments using')

        mainframeBankingSystem = model.addSoftwareSystem(Internal, 'Mainframe Banking System', 'Stores all of the core banking information about customers, accounts, transactions, etc.')
        mainframeBankingSystem.addTags(EXISTING_SYSTEM_TAG)
        internetBankingSystem.uses(mainframeBankingSystem, 'Gets account information from, and makes payments using')

        emailSystem = model.addSoftwareSystem(Location.Internal, 'E-mail System', 'The internal Microsoft Exchange e-mail system.')
        internetBankingSystem.uses(emailSystem, 'Sends e-mail using')
        emailSystem.addTags(EXISTING_SYSTEM_TAG)
        emailSystem.delivers(customer, 'Sends e-mails to')

        atm = model.addSoftwareSystem(Location.Internal, 'ATM', 'Allows customers to withdraw cash.')
        atm.addTags(EXISTING_SYSTEM_TAG)
        atm.uses(mainframeBankingSystem, 'Uses')
        customer.uses(atm, 'Withdraws cash using')

        customerServiceStaff = model.addPerson(Location.Internal, 'Customer Service Staff', 'Customer service staff within the bank.')
        customerServiceStaff.addTags(BANK_STAFF_TAG)
        customerServiceStaff.uses(mainframeBankingSystem, 'Uses')
        customer.interactsWith(customerServiceStaff, 'Asks questions to', 'Telephone')

        backOfficeStaff = model.addPerson(Location.Internal, 'Back Office Staff', 'Administration and support staff within the bank.')
        # backOfficeStaff.addTags(BANK_STAFF_TAG)
        backOfficeStaff.uses(mainframeBankingSystem, 'Uses')

        # containers
        singlePageApplication = internetBankingSystem.addContainer('Single-Page Application', 'Provides all of the Internet banking functionality to customers via their web browser.', 'JavaScript and Angular')
        singlePageApplication.addTags(WEB_BROWSER_TAG)
        mobileApp = internetBankingSystem.addContainer('Mobile App', 'Provides a limited subset of the Internet banking functionality to customers via their mobile device.', 'Xamarin')
        mobileApp.addTags(MOBILE_APP_TAG)
        webApplication = internetBankingSystem.addContainer('Web Application', 'Delivers the static content and the Internet banking single page application.', 'Java and Spring MVC')
        apiApplication = internetBankingSystem.addContainer('API Application', 'Provides Internet banking functionality via a JSON/HTTPS API.', 'Java and Spring MVC')
        database = internetBankingSystem.addContainer('Database', 'Stores user registration information, hashed authentication credentials, access logs, etc.', 'Oracle Database Schema')
        database.addTags(DATABASE_TAG)

        customer.uses(webApplication, 'Visits bigbank.com/ib using', 'HTTPS')
        customer.uses(singlePageApplication, 'Views account balances, and makes payments using', '')
        customer.uses(mobileApp, 'Views account balances, and makes payments using', '')
        webApplication.uses(singlePageApplication, "Delivers to the customer's web browser", '')
        apiApplication.uses(database, 'Reads from and writes to', 'JDBC')
        apiApplication.uses(mainframeBankingSystem, 'Makes API calls to', 'XML/HTTPS')
        apiApplication.uses(emailSystem, 'Sends e-mail using', 'SMTP')

        # components
        # - for a real-world software system, you would probably want to extract the components using
        # - static analysis/reflection rather than manually specifying them all
        signinController = apiApplication.addComponent('Sign In Controller', 'Allows users to sign in to the Internet Banking System.', 'Spring MVC Rest Controller')
        accountsSummaryController = apiApplication.addComponent('Accounts Summary Controller', 'Provides customers with a summary of their bank accounts.', 'Spring MVC Rest Controller')
        resetPasswordController = apiApplication.addComponent('Reset Password Controller', 'Allows users to reset their passwords with a single use URL.', 'Spring MVC Rest Controller')
        securityComponent = apiApplication.addComponent('Security Component', 'Provides functionality related to signing in, changing passwords, etc.', 'Spring Bean')
        mainframeBankingSystemFacade = apiApplication.addComponent('Mainframe Banking System Facade', 'A facade onto the mainframe banking system.', 'Spring Bean')
        emailComponent = apiApplication.addComponent('E-mail Component', 'Sends e-mails to users.', 'Spring Bean')

        # apiApplication.getComponents().stream().filter(c -> "Spring MVC Rest Controller".equals(c.getTechnology())).forEach(c -> singlePageApplication.uses(c, "Makes API calls to", "JSON/HTTPS"));
        # apiApplication.getComponents().stream().filter(c -> "Spring MVC Rest Controller".equals(c.getTechnology())).forEach(c -> mobileApp.uses(c, "Makes API calls to", "JSON/HTTPS"));
        signinController.uses(securityComponent, 'Uses')
        accountsSummaryController.uses(mainframeBankingSystemFacade, 'Uses')
        resetPasswordController.uses(securityComponent, 'Uses')
        resetPasswordController.uses(emailComponent, 'Uses')
        securityComponent.uses(database, 'Reads from and writes to', 'JDBC')
        mainframeBankingSystemFacade.uses(mainframeBankingSystem, 'Uses', 'XML/HTTPS')
        emailComponent.uses(emailSystem, 'Sends e-mail using')

        # deployment nodes and container instances
        developerLaptop = model.addDeploymentNode('Development', 'Developer Laptop', 'A developer laptop.', 'Microsoft Windows 10 or Apple macOS')
        apacheTomcat = developerLaptop.addDeploymentNode('Docker - Web Server', 'A Docker container.', 'Docker')
                                      .addDeploymentNode('Apache Tomcat', 'An open source Java EE web server.', 'Apache Tomcat 8.x', 1, Metal::Util::MapUtils.create('Xmx=512M', 'Xms=1024M', 'Java Version=8'))
        developmentWebApplication = apacheTomcat.add(webApplication)
        developmentApiApplication = apacheTomcat.add(apiApplication)

        developmentDatabase = developerLaptop.addDeploymentNode('Docker - Database Server', 'A Docker container.', 'Docker')
                                             .addDeploymentNode('Database Server', 'A development database.', 'Oracle 12c')
                                             .add(database)

        developmentSinglePageApplication = developerLaptop.addDeploymentNode('Web Browser', '', 'Chrome, Firefox, Safari, or Edge').add(singlePageApplication)

        customerMobileDevice = model.addDeploymentNode('Live', "Customer's mobile device", '', 'Apple iOS or Android')
        liveMobileApp = customerMobileDevice.add(mobileApp)

        customerComputer = model.addDeploymentNode('Live', "Customer's computer", '', 'Microsoft Windows or Apple macOS')
        liveSinglePageApplication = customerComputer.addDeploymentNode('Web Browser', '', 'Chrome, Firefox, Safari, or Edge').add(singlePageApplication)

        bigBankDataCenter = model.addDeploymentNode('Live', 'Big Bank plc', '', 'Big Bank plc data center')

        liveWebServer = bigBankDataCenter.addDeploymentNode('bigbank-web***', 'A web server residing in the web server farm, accessed via F5 BIG-IP LTMs.', 'Ubuntu 16.04 LTS', 4, Metal::Util::MapUtils.create('Location=London and Reading'))
        liveWebApplication = liveWebServer.addDeploymentNode('Apache Tomcat', 'An open source Java EE web server.', 'Apache Tomcat 8.x', 1, Metal::Util::MapUtils.create('Xmx=512M', 'Xms=1024M', 'Java Version=8'))
                                          .add(webApplication)

        liveApiServer = bigBankDataCenter.addDeploymentNode('bigbank-api***', 'A web server residing in the web server farm, accessed via F5 BIG-IP LTMs.', 'Ubuntu 16.04 LTS', 8, Metal::Util::MapUtils.create('Location=London and Reading'))
        liveApiApplication = liveApiServer.addDeploymentNode('Apache Tomcat', 'An open source Java EE web server.', 'Apache Tomcat 8.x', 1, Metal::Util::MapUtils.create('Xmx=512M', 'Xms=1024M', 'Java Version=8'))
                                          .add(apiApplication)

        primaryDatabaseServer = bigBankDataCenter.addDeploymentNode('bigbank-db01', 'The primary database server.', 'Ubuntu 16.04 LTS', 1, Metal::Util::MapUtils.create('Location=London'))
                                                 .addDeploymentNode('Oracle - Primary', 'The primary, live database server.', 'Oracle 12c')
        livePrimaryDatabase = primaryDatabaseServer.add(database)

        bigBankdb02 = bigBankDataCenter.addDeploymentNode('bigbank-db02', 'The secondary database server.', 'Ubuntu 16.04 LTS', 1, Metal::Util::MapUtils.create('Location=Reading'))
        bigBankdb02.addTags(FAILOVER_TAG)
        secondaryDatabaseServer = bigBankdb02.addDeploymentNode('Oracle - Secondary', 'A secondary, standby database server, used for failover purposes only.', 'Oracle 12c')
        secondaryDatabaseServer.addTags(FAILOVER_TAG)
        liveSecondaryDatabase = secondaryDatabaseServer.add(database)

        # model.getRelationships().stream().filter(r -> r.getDestination().equals(liveSecondaryDatabase)).forEach(r -> r.addTags(FAILOVER_TAG));
        dataReplicationRelationship = primaryDatabaseServer.uses(secondaryDatabaseServer, 'Replicates data to', '')
        liveSecondaryDatabase.addTags(FAILOVER_TAG)
        refute_nil workspace
      end
    end
  end
end
