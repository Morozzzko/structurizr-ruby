# frozen_string_literal: true

###
# This is an example of how to use an external theme.
#
# Source: https://github.com/structurizr/java/blob/4404b72a7283f113cb03363d581e8460711e0fd8/structurizr-examples/src/com/structurizr/example/Theme.java
# Updated at: 2020-01-05
module Structurizr
  module Examples
    class Theme < Minitest::Test
      def test_definition
        workspace = Workspace.new('Theme', 'This is a model of my software system.')
        model = workspace.get_model

        user = model.add_person('User', 'A user of my software system.')
        softwareSystem = model.add_software_system('Software System', 'My software system.')
        user.uses(softwareSystem, 'Uses')

        views = workspace.get_views
        contextView = views.create_system_context_view(softwareSystem, 'SystemContext', 'An example of a System Context diagram.')
        contextView.add_all_software_systems
        contextView.add_all_people

        ## add a theme
        views.get_configuration.set_theme('https://raw.githubusercontent.com/structurizr/java/master/structurizr-examples/src/com/structurizr/example/theme/theme.json')
      end
    end
  end
end
