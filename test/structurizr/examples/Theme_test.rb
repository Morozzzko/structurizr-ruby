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
        model = workspace.getModel

        user = model.addPerson('User', 'A user of my software system.')
        softwareSystem = model.addSoftwareSystem('Software System', 'My software system.')
        user.uses(softwareSystem, 'Uses')

        views = workspace.getViews
        contextView = views.createSystemContextView(softwareSystem, 'SystemContext', 'An example of a System Context diagram.')
        contextView.addAllSoftwareSystems
        contextView.addAllPeople

        ## add a theme
        views.getConfiguration.setTheme('https://raw.githubusercontent.com/structurizr/java/master/structurizr-examples/src/com/structurizr/example/theme/theme.json')
      end
    end
  end
end
