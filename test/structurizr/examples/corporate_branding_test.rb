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
        model = workspace.get_model

        user = model.add_person('User', 'A user of my software system.')
        softwareSystem = model.add_software_system('Software System', 'My software system.')
        user.uses(softwareSystem, 'Uses')

        views = workspace.get_views
        contextView = views.create_system_context_view(softwareSystem, 'SystemContext', 'An example of a System Context diagram.')
        contextView.add_all_software_systems
        contextView.add_all_people

        styles = views.get_configuration.get_styles
        styles.add_element_style(Tags::PERSON).shape(Shape::Person)

        template = StructurizrDocumentationTemplate.new(workspace.to_java)
        template.add_context_section(softwareSystem, Format::Markdown, "Here is some context about the software system...\n\n![](embed:SystemContext)")

        branding = views.get_configuration.get_branding
        branding.set_logo(ImageUtils.get_image_as_data_uri(java.io.file.new(File.join(__dir__, 'img/structurizr-logo.png'))))
      end
    end
  end
end
