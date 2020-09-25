# frozen_string_literal: true

###
# A "getting started" example that illustrates how to
# create a software architecture diagram using code.
#
# The live workspace is available to view at https:##structurizr.com#share#25441
# Source: https://github.com/structurizr/java/blob/533cefe8d8ac4628f0c604b106a2c1fe56082d13/structurizr-examples/src/com/structurizr/example/GettingStarted.java
# Updated at: 2017-07-13
module Structurizr
  module Examples
    class GettingStarted < Minitest::Test
      def test_definition
        ## all software architecture models belong to a workspace
        workspace = Workspace.new('Getting Started', 'This is a model of my software system.')
        model = workspace.getModel

        ## create a model to describe a user using a software system
        user = model.addPerson('User', 'A user of my software system.')
        softwareSystem = model.addSoftwareSystem('Software System', 'My software system.')
        user.uses(softwareSystem, 'Uses')

        ## create a system context diagram showing people and software systems
        views = workspace.getViews
        contextView = views.createSystemContextView(softwareSystem, 'SystemContext', 'An example of a System Context diagram.')
        contextView.addAllSoftwareSystems
        contextView.addAllPeople

        ## add some styling to the diagram elements
        styles = views.getConfiguration.getStyles
        styles.addElementStyle(Tags.SOFTWARE_SYSTEM).background('#1168bd').color('#ffffff')
        styles.addElementStyle(Tags.PERSON).background('#08427b').color('#ffffff').shape(Shape.Person)

        ## upload to structurizr.com (you'll need your own workspace ID, API key and API secret)
      end
    end
  end
end
