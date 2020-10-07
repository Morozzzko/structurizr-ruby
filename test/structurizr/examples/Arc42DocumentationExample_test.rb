# frozen_string_literal: true

###
# An empty software architecture document using the arc42 template.
#
# Source: https://github.com/structurizr/java/blob/e0db7582dc6dc7053ab995d7fff44c27d021312e/structurizr-examples/src/com/structurizr/example/Arc42DocumentationExample.java
# Updated at: 2017-07-25
module Structurizr
  module Examples
    class Arc42DocumentationExample < Minitest::Test
      attr_reader :template, :softwareSystem

      def setup
        workspace = Workspace.new('Documentation - arc42', 'An empty software architecture document using the arc42 template.')
        model = workspace.getModel
        views = workspace.getViews

        user = model.addPerson('User', 'A user of my software system.')
        @softwareSystem = model.addSoftwareSystem('Software System', 'My software system.')
        user.uses(softwareSystem, 'Uses')

        contextView = views.createSystemContextView(softwareSystem, 'SystemContext', 'An example of a System Context diagram.')
        contextView.addAllSoftwareSystems
        contextView.addAllPeople

        styles = views.getConfiguration.getStyles
        styles.addElementStyle(Tags.PERSON).shape(Shape.Person)

        @template = Arc42DocumentationTemplate.new(workspace.to_java)
      end

      def test_markdown
        documentationRoot = File.join(__dir__, 'documentation/arc42/markdown')
        template.addIntroductionAndGoalsSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '01-introduction-and-goals.md')))
        template.addConstraintsSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '02-architecture-constraints.md')))
        template.addContextAndScopeSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '03-system-scope-and-context.md')))
        template.addSolutionStrategySection(softwareSystem, java.io.File.new(File.join(documentationRoot, '04-solution-strategy.md')))
        template.addBuildingBlockViewSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '05-building-block-view.md')))
        template.addRuntimeViewSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '06-runtime-view.md')))
        template.addDeploymentViewSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '07-deployment-view.md')))
        template.addCrosscuttingConceptsSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '08-crosscutting-concepts.md')))
        template.addArchitecturalDecisionsSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '09-architecture-decisions.md')))
        template.addRisksAndTechnicalDebtSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '10-quality-requirements.md')))
        template.addQualityRequirementsSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '11-risks-and-technical-debt.md')))
        template.addGlossarySection(softwareSystem, java.io.File.new(File.join(documentationRoot, '12-glossary.md')))
      end

      def test_asciidoc
        documentationRoot = File.join(__dir__, 'documentation/arc42/asciidoc')
        template.addIntroductionAndGoalsSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '01-introduction-and-goals.adoc')))
        template.addConstraintsSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '02-architecture-constraints.adoc')))
        template.addContextAndScopeSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '03-system-scope-and-context.adoc')))
        template.addSolutionStrategySection(softwareSystem, java.io.File.new(File.join(documentationRoot, '04-solution-strategy.adoc')))
        template.addBuildingBlockViewSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '05-building-block-view.adoc')))
        template.addRuntimeViewSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '06-runtime-view.adoc')))
        template.addDeploymentViewSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '07-deployment-view.adoc')))
        template.addCrosscuttingConceptsSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '08-crosscutting-concepts.adoc')))
        template.addArchitecturalDecisionsSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '09-architecture-decisions.adoc')))
        template.addRisksAndTechnicalDebtSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '10-quality-requirements.adoc')))
        template.addQualityRequirementsSection(softwareSystem, java.io.File.new(File.join(documentationRoot, '11-risks-and-technical-debt.adoc')))
        template.addGlossarySection(softwareSystem, java.io.File.new(File.join(documentationRoot, '12-glossary.adoc')))
      end
    end
  end
end
