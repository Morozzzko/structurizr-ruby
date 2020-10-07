# frozen_string_literal: true

###
# An empty software architecture document using the Structurizr template.
#
# Source: https://github.com/structurizr/java/blob/e0db7582dc6dc7053ab995d7fff44c27d021312e/structurizr-examples/src/com/structurizr/example/StructurizrDocumentationExample.java
# Updated at: 2017-07-25
module Structurizr
  module Examples
    class StructurizrDocumentationExample < Minitest::Test
      attr_reader :template

      def setup
        workspace = Workspace.new('Documentation - Structurizr', 'An empty software architecture document using the Structurizr template.')
        model = workspace.getModel
        views = workspace.getViews

        user = model.addPerson('User', 'A user of my software system.')
        softwareSystem = model.addSoftwareSystem('Software System', 'My software system.')
        user.uses(softwareSystem, 'Uses')

        contextView = views.createSystemContextView(softwareSystem, 'SystemContext', 'An example of a System Context diagram.')
        contextView.addAllSoftwareSystems
        contextView.addAllPeople

        styles = views.getConfiguration.getStyles
        styles.addElementStyle(Tags.PERSON).shape(Shape.Person)

        @template = StructurizrDocumentationTemplate.new(workspace.to_java)
      end

      def test_markdown
        documentationRoot = java.io.File.new(File.join(__dir__, 'documentation/structurizr/markdown'))
        template.addContextSection(softwareSystem, java.io.File.new(documentationRoot, '01-context.md'))
        template.addFunctionalOverviewSection(softwareSystem, java.io.File.new(documentationRoot, '02-functional-overview.md'))
        template.addQualityAttributesSection(softwareSystem, java.io.File.new(documentationRoot, '03-quality-attributes.md'))
        template.addConstraintsSection(softwareSystem, java.io.File.new(documentationRoot, '04-constraints.md'))
        template.addPrinciplesSection(softwareSystem, java.io.File.new(documentationRoot, '05-principles.md'))
        template.addSoftwareArchitectureSection(softwareSystem, java.io.File.new(documentationRoot, '06-software-architecture.md'))
        template.addDataSection(softwareSystem, java.io.File.new(documentationRoot, '07-data.md'))
        template.addInfrastructureArchitectureSection(softwareSystem, java.io.File.new(documentationRoot, '08-infrastructure-architecture.md'))
        template.addDeploymentSection(softwareSystem, java.io.File.new(documentationRoot, '09-deployment.md'))
        template.addDevelopmentEnvironmentSection(softwareSystem, java.io.File.new(documentationRoot, '10-development-environment.md'))
        template.addOperationAndSupportSection(softwareSystem, java.io.File.new(documentationRoot, '11-operation-and-support.md'))
        template.addDecisionLogSection(softwareSystem, java.io.File.new(documentationRoot, '12-decision-log.md'))
      end

      def test_asciidoc
        documentationRoot = java.io.File.new(File.join(__dir__, 'documentation/structurizr/asciidoc'))
        template.addContextSection(softwareSystem, java.io.File.new(documentationRoot, '01-context.adoc'))
        template.addFunctionalOverviewSection(softwareSystem, java.io.File.new(documentationRoot, '02-functional-overview.adoc'))
        template.addQualityAttributesSection(softwareSystem, java.io.File.new(documentationRoot, '03-quality-attributes.adoc'))
        template.addConstraintsSection(softwareSystem, java.io.File.new(documentationRoot, '04-constraints.adoc'))
        template.addPrinciplesSection(softwareSystem, java.io.File.new(documentationRoot, '05-principles.adoc'))
        template.addSoftwareArchitectureSection(softwareSystem, java.io.File.new(documentationRoot, '06-software-architecture.adoc'))
        template.addDataSection(softwareSystem, java.io.File.new(documentationRoot, '07-data.adoc'))
        template.addInfrastructureArchitectureSection(softwareSystem, java.io.File.new(documentationRoot, '08-infrastructure-architecture.adoc'))
        template.addDeploymentSection(softwareSystem, java.io.File.new(documentationRoot, '09-deployment.adoc'))
        template.addDevelopmentEnvironmentSection(softwareSystem, java.io.File.new(documentationRoot, '10-development-environment.adoc'))
        template.addOperationAndSupportSection(softwareSystem, java.io.File.new(documentationRoot, '11-operation-and-support.adoc'))
        template.addDecisionLogSection(softwareSystem, java.io.File.new(documentationRoot, '12-decision-log.adoc'))
      end
    end
  end
end
