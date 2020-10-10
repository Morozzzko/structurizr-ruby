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
        model = workspace.get_model

        model.add_software_system('Box', 'Description').add_tags('Box')
        model.add_software_system('RoundedBox', 'Description').add_tags('RoundedBox')
        model.add_software_system('Ellipse', 'Description').add_tags('Ellipse')
        model.add_software_system('Circle', 'Description').add_tags('Circle')
        model.add_software_system('Hexagon', 'Description').add_tags('Hexagon')
        model.add_software_system('Cylinder', 'Description').add_tags('Cylinder')
        model.add_software_system('WebBrowser', 'Description').add_tags('Web Browser')
        model.add_software_system('Mobile Device Portrait', 'Description').add_tags('Mobile Device Portrait')
        model.add_software_system('Mobile Device Landscape', 'Description').add_tags('Mobile Device Landscape')
        model.add_software_system('Pipe', 'Description').add_tags('Pipe')
        model.add_software_system('Folder', 'Description').add_tags('Folder')
        model.add_software_system('Robot', 'Description').add_tags('Robot')
        model.add_person('Person', 'Description').add_tags('Person')
        model.add_software_system('Component', 'Description').add_tags('Component')

        views = workspace.get_views
        view = views.create_system_landscape_view('shapes', 'An example of all shapes available in Structurizr.')
        view.add_all_elements
        view.set_paper_size(PaperSize::A5_Landscape)

        styles = views.get_configuration.get_styles

        styles.add_element_style(Tags::ELEMENT).color('#ffffff').background('#438dd5').font_size(34).width(650).height(400).description(false).metadata(false)
        styles.add_element_style('Box').shape(Shape::Box)
        styles.add_element_style('RoundedBox').shape(Shape::RoundedBox)
        styles.add_element_style('Ellipse').shape(Shape::Ellipse)
        styles.add_element_style('Circle').shape(Shape::Circle)
        styles.add_element_style('Cylinder').shape(Shape::Cylinder)
        styles.add_element_style('Web Browser').shape(Shape::WebBrowser)
        styles.add_element_style('Mobile Device Portrait').shape(Shape::MobileDevicePortrait).width(400).height(650)
        styles.add_element_style('Mobile Device Landscape').shape(Shape::MobileDeviceLandscape)
        styles.add_element_style('Pipe').shape(Shape::Pipe)
        styles.add_element_style('Folder').shape(Shape::Folder)
        styles.add_element_style('Hexagon').shape(Shape::Hexagon)
        styles.add_element_style('Robot').shape(Shape::Robot).width(550)
        styles.add_element_style('Person').shape(Shape::Person).width(550)
        styles.add_element_style('Component').shape(Shape::Component)
      end
    end
  end
end
