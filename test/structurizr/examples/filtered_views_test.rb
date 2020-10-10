# frozen_string_literal: true

###
# An example of how to use filtered views to show "before" and "after" views of a software system.
#
# Source: https://github.com/structurizr/java/blob/1ddbb44e7a0c5123fbecddfe61837980e9bbb8dd/structurizr-examples/src/com/structurizr/example/FilteredViews.java
# Updated at: 2018-01-31
module Structurizr
  module Examples
    class FilteredViews < Minitest::Test
      CURRENT_STATE = 'Current State'
      FUTURE_STATE = 'Future State'

      def test_definition
        workspace = Workspace.new('Filtered Views', 'An example of using filtered views.')
        model = workspace.get_model

        user = model.add_person('User', 'A description of the user.')
        softwareSystemA = model.add_software_system('Software System A', 'A description of software system A.')
        softwareSystemB = model.add_software_system('Software System B', 'A description of software system B.')
        softwareSystemB.add_tags(FUTURE_STATE)

        user.uses(softwareSystemA, 'Uses for tasks 1 and 2').add_tags(CURRENT_STATE)
        user.uses(softwareSystemA, 'Uses for task 1').add_tags(FUTURE_STATE)
        user.uses(softwareSystemB, 'Uses for task 2').add_tags(FUTURE_STATE)

        views = workspace.get_views
        systemLandscapeView = views.create_system_landscape_view('SystemLandscape', 'An example System Landscape diagram.')
        systemLandscapeView.add_all_elements

        views.create_filtered_view(systemLandscapeView, 'CurrentState', 'The current system landscape.', FilterMode::Exclude, FUTURE_STATE)
        views.create_filtered_view(systemLandscapeView, 'FutureState', 'The future state system landscape after Software System B is live.', FilterMode::Exclude, CURRENT_STATE)

        styles = views.get_configuration.get_styles
        styles.add_element_style(Tags::ELEMENT).color('#ffffff')
        styles.add_element_style(Tags::SOFTWARE_SYSTEM).background('#91a437').shape(Shape::RoundedBox)
        styles.add_element_style(Tags::PERSON).background('#6a7b15').shape(Shape::Person)
      end
    end
  end
end
