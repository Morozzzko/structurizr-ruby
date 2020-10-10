# frozen_string_literal: true

###
# <p>
#   This is a simple example that illustrates the corporate branding features of Structurizr, including:
# <#p>
#
# <ul>
#   <li>A logo, which is included in diagrams and documentation.<#li>
# <#ul>
#
# <p>
# <#p>
# Source: https://github.com/structurizr/java/blob/2b3e0828128ae9dfc6420a39f6ad9f5ecd987450/structurizr-examples/src/com/structurizr/example/CorporateBranding.java
# Updated at: 2018-09-03
module Structurizr
  module Examples
    class CorporateBranding < Minitest::Test
      def test_definition
        workspace = Workspace.new('Corporate Branding', 'This is a model of my software system.')
        model = workspace.getModel

        user = model.addPerson('User', 'A user of my software system.')
        softwareSystem = model.addSoftwareSystem('Software System', 'My software system.')
        user.uses(softwareSystem, 'Uses')

        views = workspace.getViews
        contextView = views.createSystemContextView(softwareSystem, 'SystemContext', 'An example of a System Context diagram.')
        contextView.addAllSoftwareSystems
        contextView.addAllPeople

        styles = views.getConfiguration.getStyles
        styles.addElementStyle(Tags::PERSON).shape(Shape::Person)

        template = StructurizrDocumentationTemplate.new(workspace.to_java)
        template.addContextSection(softwareSystem, Format::Markdown, "Here is some context about the software system...\n\n![](embed:SystemContext)")

        branding = views.getConfiguration.getBranding
        branding.setLogo(ImageUtils.getImageAsDataUri(java.io.File.new(File.join(__dir__, 'img/structurizr-logo.png'))))
      end
    end
  end
end
