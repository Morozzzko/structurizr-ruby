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
        model = workspace.getModel

        user = model.addPerson('User', 'A description of the user.')
        softwareSystemA = model.addSoftwareSystem('Software System A', 'A description of software system A.')
        softwareSystemB = model.addSoftwareSystem('Software System B', 'A description of software system B.')
        softwareSystemB.addTags(FUTURE_STATE)

        user.uses(softwareSystemA, 'Uses for tasks 1 and 2').addTags(CURRENT_STATE)
        user.uses(softwareSystemA, 'Uses for task 1').addTags(FUTURE_STATE)
        user.uses(softwareSystemB, 'Uses for task 2').addTags(FUTURE_STATE)

        views = workspace.getViews
        systemLandscapeView = views.createSystemLandscapeView('SystemLandscape', 'An example System Landscape diagram.')
        systemLandscapeView.addAllElements

        views.createFilteredView(systemLandscapeView, 'CurrentState', 'The current system landscape.', FilterMode.Exclude, FUTURE_STATE)
        views.createFilteredView(systemLandscapeView, 'FutureState', 'The future state system landscape after Software System B is live.', FilterMode.Exclude, CURRENT_STATE)

        styles = views.getConfiguration.getStyles
        styles.addElementStyle(Tags.ELEMENT).color('#ffffff')
        styles.addElementStyle(Tags.SOFTWARE_SYSTEM).background('#91a437').shape(Shape.RoundedBox)
        styles.addElementStyle(Tags.PERSON).background('#6a7b15').shape(Shape.Person)
      end
    end
  end
end
