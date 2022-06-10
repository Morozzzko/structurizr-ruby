# frozen_string_literal: true

###
# This is an example workspace to illustrate the key features of Structurizr,
# based around a fictional Internet Banking System for Big Bank plc.
#
# Source: https://github.com/structurizr/java/blob/e69e59d9fcc58c74272647a31cf29f8b2d51bb58/structurizr-examples/src/com/structurizr/example/BigBankPlc.java
# Updated at: 2020-08-04
module Structurizr
  module Examples
    class BigBankPlc < Minitest::Test
      EXISTING_SYSTEM_TAG = 'Existing System'
      BANK_STAFF_TAG = 'Bank Staff'
      WEB_BROWSER_TAG = 'Web Browser'
      MOBILE_APP_TAG = 'Mobile App'
      DATABASE_TAG = 'Database'
      FAILOVER_TAG = 'Failover'

      MapUtils = Metal::Util::MapUtils

      def test_definition
        workspace = Workspace.new('Big Bank plc', 'This is an example workspace to illustrate the key features of Structurizr, based around a fictional online banking system.')
        model = workspace.get_model
        model.set_implied_relationships_strategy(Metal::Model::CreateImpliedRelationshipsUnlessAnyRelationshipExistsStrategy.new)
        views = workspace.get_views

        model.set_enterprise(Enterprise.new('Big Bank plc'))

        ## people and software systems
        customer = model.add_person(Location::External, 'Personal Banking Customer', 'A customer of the bank, with personal bank accounts.')

        internetBankingSystem = model.add_software_system(Location::Internal, 'Internet Banking System', 'Allows customers to view information about their bank accounts, and make payments.')
        customer.uses(internetBankingSystem, 'Views account balances, and makes payments using')

        mainframeBankingSystem = model.add_software_system(Location::Internal, 'Mainframe Banking System', 'Stores all of the core banking information about customers, accounts, transactions, etc.')
        mainframeBankingSystem.add_tags(EXISTING_SYSTEM_TAG)
        internetBankingSystem.uses(mainframeBankingSystem, 'Gets account information from, and makes payments using')

        emailSystem = model.add_software_system(Location::Internal, 'E-mail System', 'The internal Microsoft Exchange e-mail system.')
        internetBankingSystem.uses(emailSystem, 'Sends e-mail using')
        emailSystem.add_tags(EXISTING_SYSTEM_TAG)
        emailSystem.delivers(customer, 'Sends e-mails to')

        atm = model.add_software_system(Location::Internal, 'ATM', 'Allows customers to withdraw cash.')
        atm.add_tags(EXISTING_SYSTEM_TAG)
        atm.uses(mainframeBankingSystem, 'Uses')
        customer.uses(atm, 'Withdraws cash using')

        customerServiceStaff = model.add_person(Location::Internal, 'Customer Service Staff', 'Customer service staff within the bank.')
        customerServiceStaff.add_tags(BANK_STAFF_TAG)
        customerServiceStaff.uses(mainframeBankingSystem, 'Uses')
        customer.interacts_with(customerServiceStaff, 'Asks questions to', 'Telephone')

        backOfficeStaff = model.add_person(Location::Internal, 'Back Office Staff', 'Administration and support staff within the bank.')
        backOfficeStaff.add_tags(BANK_STAFF_TAG)
        backOfficeStaff.uses(mainframeBankingSystem, 'Uses')

        ## containers
        singlePageApplication = internetBankingSystem.add_container('Single-Page Application', 'Provides all of the Internet banking functionality to customers via their web browser.', 'JavaScript and Angular')
        singlePageApplication.add_tags(WEB_BROWSER_TAG)
        mobileApp = internetBankingSystem.add_container('Mobile App', 'Provides a limited subset of the Internet banking functionality to customers via their mobile device.', 'Xamarin')
        mobileApp.add_tags(MOBILE_APP_TAG)
        webApplication = internetBankingSystem.add_container('Web Application', 'Delivers the static content and the Internet banking single page application.', 'Java and Spring MVC')
        apiApplication = internetBankingSystem.add_container('API Application', 'Provides Internet banking functionality via a JSON#HTTPS API.', 'Java and Spring MVC')
        database = internetBankingSystem.add_container('Database', 'Stores user registration information, hashed authentication credentials, access logs, etc.', 'Oracle Database Schema')
        database.add_tags(DATABASE_TAG)

        customer.uses(webApplication, 'Visits bigbank.com#ib using', 'HTTPS')
        customer.uses(singlePageApplication, 'Views account balances, and makes payments using', '')
        customer.uses(mobileApp, 'Views account balances, and makes payments using', '')
        webApplication.uses(singlePageApplication, "Delivers to the customer's web browser", '')
        apiApplication.uses(database, 'Reads from and writes to', 'JDBC')
        apiApplication.uses(mainframeBankingSystem, 'Makes API calls to', 'XML#HTTPS')
        apiApplication.uses(emailSystem, 'Sends e-mail using', 'SMTP')

        ## components
        ## - for a real-world software system, you would probably want to extract the components using
        ## - static analysis#reflection rather than manually specifying them all
        signinController = apiApplication.add_component('Sign In Controller', 'Allows users to sign in to the Internet Banking System.', 'Spring MVC Rest Controller')
        accountsSummaryController = apiApplication.add_component('Accounts Summary Controller', 'Provides customers with a summary of their bank accounts.', 'Spring MVC Rest Controller')
        resetPasswordController = apiApplication.add_component('Reset Password Controller', 'Allows users to reset their passwords with a single use URL.', 'Spring MVC Rest Controller')
        securityComponent = apiApplication.add_component('Security Component', 'Provides functionality related to signing in, changing passwords, etc.', 'Spring Bean')
        mainframeBankingSystemFacade = apiApplication.add_component('Mainframe Banking System Facade', 'A facade onto the mainframe banking system.', 'Spring Bean')
        emailComponent = apiApplication.add_component('E-mail Component', 'Sends e-mails to users.', 'Spring Bean')

        apiApplication.get_components.select do |component|
          component.get_technology == 'Spring MVC Rest Controller'
        end.each do |component|
          singlePageApplication.uses(component, 'Makes API calls to', 'JSON/HTTPS')
        end
        apiApplication.get_components.select do |component|
          component.get_technology == 'Spring MVC Rest Controller'
        end.each do |component|
          mobileApp.uses(component, 'Makes API calls to', 'JSON/HTTPS')
        end

        signinController.uses(securityComponent, 'Uses')
        accountsSummaryController.uses(mainframeBankingSystemFacade, 'Uses')
        resetPasswordController.uses(securityComponent, 'Uses')
        resetPasswordController.uses(emailComponent, 'Uses')
        securityComponent.uses(database, 'Reads from and writes to', 'JDBC')
        mainframeBankingSystemFacade.uses(mainframeBankingSystem, 'Uses', 'XML#HTTPS')
        emailComponent.uses(emailSystem, 'Sends e-mail using')

        ## deployment nodes and container instances
        developerLaptop = model.add_deployment_node('Development', 'Developer Laptop', 'A developer laptop.', 'Microsoft Windows 10 or Apple macOS')
        apacheTomcat = developerLaptop.add_deployment_node('Docker Container - Web Server', 'A Docker container.', 'Docker')
                                      .add_deployment_node('Apache Tomcat', 'An open source Java EE web server.', 'Apache Tomcat 8.x', 1, MapUtils.create('Xmx=512M', 'Xms=1024M', 'Java Version=8'))
        developmentWebApplication = apacheTomcat.add(webApplication)
        developmentApiApplication = apacheTomcat.add(apiApplication)

        bigBankDataCenterForDevelopment = model.add_deployment_node('Development', 'Big Bank plc', '', 'Big Bank plc data center')
        developmentMainframeBankingSystem = bigBankDataCenterForDevelopment.add_deployment_node('bigbank-dev001').add(mainframeBankingSystem)

        developmentDatabase = developerLaptop.add_deployment_node('Docker Container - Database Server', 'A Docker container.', 'Docker')
                                             .add_deployment_node('Database Server', 'A development database.', 'Oracle 12c')
                                             .add(database)

        developmentSinglePageApplication = developerLaptop.add_deployment_node('Web Browser', '', 'Chrome, Firefox, Safari, or Edge').add(singlePageApplication)

        customerMobileDevice = model.add_deployment_node('Live', "Customer's mobile device", '', 'Apple iOS or Android')
        liveMobileApp = customerMobileDevice.add(mobileApp)

        customerComputer = model.add_deployment_node('Live', "Customer's computer", '', 'Microsoft Windows or Apple macOS')
        liveSinglePageApplication = customerComputer.add_deployment_node('Web Browser', '', 'Chrome, Firefox, Safari, or Edge').add(singlePageApplication)

        bigBankDataCenterForLive = model.add_deployment_node('Live', 'Big Bank plc', '', 'Big Bank plc data center')
        liveMainframeBankingSystem = bigBankDataCenterForLive.add_deployment_node('bigbank-prod001').add(mainframeBankingSystem)

        liveWebServer = bigBankDataCenterForLive.add_deployment_node('bigbank-web###', 'A web server residing in the web server farm, accessed via F5 BIG-IP LTMs.', 'Ubuntu 16.04 LTS', 4, MapUtils.create('Location=London and Reading'))
        liveWebApplication = liveWebServer.add_deployment_node('Apache Tomcat', 'An open source Java EE web server.', 'Apache Tomcat 8.x', 1, MapUtils.create('Xmx=512M', 'Xms=1024M', 'Java Version=8'))
                                          .add(webApplication)

        liveApiServer = bigBankDataCenterForLive.add_deployment_node('bigbank-api###', 'A web server residing in the web server farm, accessed via F5 BIG-IP LTMs.', 'Ubuntu 16.04 LTS', 8, MapUtils.create('Location=London and Reading'))
        liveApiApplication = liveApiServer.add_deployment_node('Apache Tomcat', 'An open source Java EE web server.', 'Apache Tomcat 8.x', 1, MapUtils.create('Xmx=512M', 'Xms=1024M', 'Java Version=8'))
                                          .add(apiApplication)

        primaryDatabaseServer = bigBankDataCenterForLive.add_deployment_node('bigbank-db01', 'The primary database server.', 'Ubuntu 16.04 LTS', 1, MapUtils.create('Location=London'))
                                                        .add_deployment_node('Oracle - Primary', 'The primary, live database server.', 'Oracle 12c')
        livePrimaryDatabase = primaryDatabaseServer.add(database)

        bigBankdb02 = bigBankDataCenterForLive.add_deployment_node('bigbank-db02', 'The secondary database server.', 'Ubuntu 16.04 LTS', 1, MapUtils.create('Location=Reading'))
        bigBankdb02.add_tags(FAILOVER_TAG)
        secondaryDatabaseServer = bigBankdb02.add_deployment_node('Oracle - Secondary', 'A secondary, standby database server, used for failover purposes only.', 'Oracle 12c')
        secondaryDatabaseServer.add_tags(FAILOVER_TAG)
        liveSecondaryDatabase = secondaryDatabaseServer.add(database)

        model.get_relationships.select do |relationship|
          relationship.get_destination == liveSecondaryDatabase
        end.map do |relationship|
          relationship.add_tags(FAILOVER_TAG)
        end

        dataReplicationRelationship = primaryDatabaseServer.uses(secondaryDatabaseServer, 'Replicates data to', '')
        liveSecondaryDatabase.add_tags(FAILOVER_TAG)

        ## views#diagrams
        systemLandscapeView = views.create_system_landscape_view('SystemLandscape', 'The system landscape diagram for Big Bank plc.')
        systemLandscapeView.add_all_elements
        systemLandscapeView.set_paper_size(PaperSize::A5_Landscape)

        systemContextView = views.create_system_context_view(internetBankingSystem, 'SystemContext', 'The system context diagram for the Internet Banking System.')
        systemContextView.set_enterprise_boundary_visible(false)
        systemContextView.add_nearest_neighbours(internetBankingSystem)
        systemContextView.set_paper_size(PaperSize::A5_Landscape)

        containerView = views.create_container_view(internetBankingSystem, 'Containers', 'The container diagram for the Internet Banking System.')
        containerView.add(customer)
        containerView.add_all_containers
        containerView.add(mainframeBankingSystem)
        containerView.add(emailSystem)
        containerView.set_paper_size(PaperSize::A5_Landscape)

        componentView = views.create_component_view(apiApplication, 'Components', 'The component diagram for the API Application.')
        componentView.add(mobileApp)
        componentView.add(singlePageApplication)
        componentView.add(database)
        componentView.add_all_components
        componentView.add(mainframeBankingSystem)
        componentView.add(emailSystem)
        componentView.set_paper_size(PaperSize::A5_Landscape)

        systemLandscapeView.add_animation(internetBankingSystem, customer, mainframeBankingSystem, emailSystem)
        systemLandscapeView.add_animation(atm)
        systemLandscapeView.add_animation(customerServiceStaff, backOfficeStaff)

        systemContextView.add_animation(internetBankingSystem)
        systemContextView.add_animation(customer)
        systemContextView.add_animation(mainframeBankingSystem)
        systemContextView.add_animation(emailSystem)

        containerView.add_animation(customer, mainframeBankingSystem, emailSystem)
        containerView.add_animation(webApplication)
        containerView.add_animation(singlePageApplication)
        containerView.add_animation(mobileApp)
        containerView.add_animation(apiApplication)
        containerView.add_animation(database)

        componentView.add_animation(singlePageApplication, mobileApp, database, emailSystem, mainframeBankingSystem)
        componentView.add_animation(signinController, securityComponent)
        componentView.add_animation(accountsSummaryController, mainframeBankingSystemFacade)
        componentView.add_animation(resetPasswordController, emailComponent)

        ## dynamic diagrams and deployment diagrams are not available with the Free Plan
        dynamicView = views.create_dynamic_view(apiApplication, 'SignIn', 'Summarises how the sign in feature works in the single-page application.')
        dynamicView.add(singlePageApplication, 'Submits credentials to', signinController)
        dynamicView.add(signinController, 'Validates credentials using', securityComponent)
        dynamicView.add(securityComponent, 'select # from users where username = ?', database)
        dynamicView.add(database, 'Returns user data to', securityComponent)
        dynamicView.add(securityComponent, 'Returns true if the hashed password matches', signinController)
        dynamicView.add(signinController, 'Sends back an authentication token to', singlePageApplication)
        dynamicView.set_paper_size(PaperSize::A5_Landscape)

        developmentDeploymentView = views.create_deployment_view(internetBankingSystem, 'DevelopmentDeployment', 'An example development deployment scenario for the Internet Banking System.')
        developmentDeploymentView.set_environment('Development')
        developmentDeploymentView.add(developerLaptop)
        developmentDeploymentView.add(bigBankDataCenterForDevelopment)
        developmentDeploymentView.set_paper_size(PaperSize::A5_Landscape)

        developmentDeploymentView.add_animation(developmentSinglePageApplication)
        developmentDeploymentView.add_animation(developmentWebApplication, developmentApiApplication)
        developmentDeploymentView.add_animation(developmentDatabase)
        developmentDeploymentView.add_animation(developmentMainframeBankingSystem)

        liveDeploymentView = views.create_deployment_view(internetBankingSystem, 'LiveDeployment', 'An example live deployment scenario for the Internet Banking System.')
        liveDeploymentView.set_environment('Live')
        liveDeploymentView.add(bigBankDataCenterForLive)
        liveDeploymentView.add(customerMobileDevice)
        liveDeploymentView.add(customerComputer)
        liveDeploymentView.add(dataReplicationRelationship)
        liveDeploymentView.set_paper_size(PaperSize::A4_Landscape)

        liveDeploymentView.add_animation(liveSinglePageApplication)
        liveDeploymentView.add_animation(liveMobileApp)
        liveDeploymentView.add_animation(liveWebApplication, liveApiApplication)
        liveDeploymentView.add_animation(livePrimaryDatabase)
        liveDeploymentView.add_animation(liveSecondaryDatabase)
        liveDeploymentView.add_animation(liveMainframeBankingSystem)

        ## colours, shapes and other diagram styling
        styles = views.get_configuration.get_styles
        styles.add_element_style(Tags::SOFTWARE_SYSTEM).background('#1168bd').color('#ffffff')
        styles.add_element_style(Tags::CONTAINER).background('#438dd5').color('#ffffff')
        styles.add_element_style(Tags::COMPONENT).background('#85bbf0').color('#000000')
        styles.add_element_style(Tags::PERSON).background('#08427b').color('#ffffff').shape(Shape::Person).font_size(22)
        styles.add_element_style(EXISTING_SYSTEM_TAG).background('#999999').color('#ffffff')
        styles.add_element_style(BANK_STAFF_TAG).background('#999999').color('#ffffff')
        styles.add_element_style(WEB_BROWSER_TAG).shape(Shape::WebBrowser)
        styles.add_element_style(MOBILE_APP_TAG).shape(Shape::MobileDeviceLandscape)
        styles.add_element_style(DATABASE_TAG).shape(Shape::Cylinder)
        styles.add_element_style(FAILOVER_TAG).opacity(25)
        styles.add_relationship_style(FAILOVER_TAG).opacity(25).position(70)

        ## documentation
        ## - usually the documentation would be included from separate Markdown#AsciiDoc files, but this is just an example
        template = StructurizrDocumentationTemplate.new(workspace)
        template.add_context_section(internetBankingSystem, Format::Markdown,
                                     "Here is some context about the Internet Banking System...\n" \
                                             "![](embed:SystemLandscape)\n" \
                                             "![](embed:SystemContext)\n" \
                                             "### Internet Banking System\n...\n" \
                                             "### Mainframe Banking System\n...\n")
        template.add_containers_section(internetBankingSystem, Format::Markdown,
                                        "Here is some information about the containers within the Internet Banking System...\n" \
                                                "![](embed:Containers)\n" \
                                                "### Web Application\n...\n" \
                                                "### Database\n...\n")
        template.add_components_section(webApplication, Format::Markdown,
                                        "Here is some information about the API Application...\n" \
                                                "![](embed:Components)\n" \
                                                "### Sign in process\n" \
                                                "Here is some information about the Sign In Controller, including how the sign in process works...\n" \
                                                '![](embed:SignIn)')
        template.add_development_environment_section(internetBankingSystem, Format::AsciiDoc,
                                                     "Here is some information about how to set up a development environment for the Internet Banking System...\n" \
                                                             'image::embed:DevelopmentDeployment[]')
        template.add_deployment_section(internetBankingSystem, Format::AsciiDoc,
                                        "Here is some information about the live deployment environment for the Internet Banking System...\n" \
                                                'image::embed:LiveDeployment[]')
      end
    end
  end
end
