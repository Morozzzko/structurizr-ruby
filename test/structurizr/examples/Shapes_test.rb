# frozen_string_literal: true

###
# An example illustrating all of the shapes available in Structurizr.
#
# Source: https://github.com/structurizr/java/blob/1689bf44fb907df7a375ab2c0f570938b8adf2e6/structurizr-examples/src/com/structurizr/example/Shapes.java
# Updated at: 2020-06-05
module Structurizr
  module Examples
    class Shapes < Minitest::Test
      def test_definition
        workspace = Workspace.new('Shapes', 'An example of all shapes available in Structurizr.')
        model = workspace.getModel

        model.addSoftwareSystem('Box', 'Description').addTags('Box')
        model.addSoftwareSystem('RoundedBox', 'Description').addTags('RoundedBox')
        model.addSoftwareSystem('Ellipse', 'Description').addTags('Ellipse')
        model.addSoftwareSystem('Circle', 'Description').addTags('Circle')
        model.addSoftwareSystem('Hexagon', 'Description').addTags('Hexagon')
        model.addSoftwareSystem('Cylinder', 'Description').addTags('Cylinder')
        model.addSoftwareSystem('WebBrowser', 'Description').addTags('Web Browser')
        model.addSoftwareSystem('Mobile Device Portrait', 'Description').addTags('Mobile Device Portrait')
        model.addSoftwareSystem('Mobile Device Landscape', 'Description').addTags('Mobile Device Landscape')
        model.addSoftwareSystem('Pipe', 'Description').addTags('Pipe')
        model.addSoftwareSystem('Folder', 'Description').addTags('Folder')
        model.addSoftwareSystem('Robot', 'Description').addTags('Robot')
        model.addPerson('Person', 'Description').addTags('Person')
        model.addSoftwareSystem('Component', 'Description').addTags('Component')

        views = workspace.getViews
        view = views.createSystemLandscapeView('shapes', 'An example of all shapes available in Structurizr.')
        view.addAllElements
        view.setPaperSize(PaperSize.A5_Landscape)

        styles = views.getConfiguration.getStyles

        styles.addElementStyle(Tags.ELEMENT).color('#ffffff').background('#438dd5').fontSize(34).width(650).height(400).description(false).metadata(false)
        styles.addElementStyle('Box').shape(Shape.Box)
        styles.addElementStyle('RoundedBox').shape(Shape.RoundedBox)
        styles.addElementStyle('Ellipse').shape(Shape.Ellipse)
        styles.addElementStyle('Circle').shape(Shape.Circle)
        styles.addElementStyle('Cylinder').shape(Shape.Cylinder)
        styles.addElementStyle('Web Browser').shape(Shape.WebBrowser)
        styles.addElementStyle('Mobile Device Portrait').shape(Shape.MobileDevicePortrait).width(400).height(650)
        styles.addElementStyle('Mobile Device Landscape').shape(Shape.MobileDeviceLandscape)
        styles.addElementStyle('Pipe').shape(Shape.Pipe)
        styles.addElementStyle('Folder').shape(Shape.Folder)
        styles.addElementStyle('Hexagon').shape(Shape.Hexagon)
        styles.addElementStyle('Robot').shape(Shape.Robot).width(550)
        styles.addElementStyle('Person').shape(Shape.Person).width(550)
        styles.addElementStyle('Component').shape(Shape.Component)
      end
    end
  end
end
