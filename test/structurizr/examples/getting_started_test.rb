# frozen_string_literal: true

###
# A "getting started" example that illustrates how to
# create a software architecture diagram using code.
#
# Source: https://github.com/structurizr/java/blob/533cefe8d8ac4628f0c604b106a2c1fe56082d13/structurizr-examples/src/com/structurizr/example/GettingStarted.java
# Updated at: 2017-07-13
module Structurizr
  module Examples
    class GettingStarted < Minitest::Test
      def test_definition
        ## all software architecture models belong to a workspace
        workspace = Workspace.new('Getting Started', 'This is a model of my software system.')
        model = workspace.get_model

        ## create a model to describe a user using a software system
        user = model.add_person('User', 'A user of my software system.')
        softwareSystem = model.add_software_system('Software System', 'My software system.')
        user.uses(softwareSystem, 'Uses')

        ## create a system context diagram showing people and software systems
        views = workspace.get_views
        contextView = views.create_system_context_view(softwareSystem, 'SystemContext', 'An example of a System Context diagram.')
        contextView.add_all_software_systems
        contextView.add_all_people

        ## add some styling to the diagram elements
        styles = views.get_configuration.get_styles
        styles.add_element_style(Tags::SOFTWARE_SYSTEM).background('#1168bd').color('#ffffff')
        styles.add_element_style(Tags::PERSON).background('#08427b').color('#ffffff').shape(Shape::Person)

        ## upload to structurizr.com (you'll need your own workspace ID, API key and API secret)
      end
    end
  end
end
