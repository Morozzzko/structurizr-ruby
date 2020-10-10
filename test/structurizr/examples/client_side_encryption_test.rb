# frozen_string_literal: true

###
# This is an example of how to use client-side encryption.
#
# (the passphrase is "password")
# Source: https://github.com/structurizr/java/blob/71e3fc9f8750882e264800a3c394c1eb5bbc8c16/structurizr-examples/src/com/structurizr/example/ClientSideEncryption.java
# Updated at: 2017-07-19
module Structurizr
  module Examples
    class ClientSideEncryption < Minitest::Test
      def test_definition
        workspace = Workspace.new('Client-side encrypted workspace', "This is a client-side encrypted workspace. The passphrase is 'password'.")
        model = workspace.getModel

        user = model.addPerson('User', 'A user of my software system.')
        softwareSystem = model.addSoftwareSystem('Software System', 'My software system.')
        user.uses(softwareSystem, 'Uses')

        views = workspace.getViews
        contextView = views.createSystemContextView(softwareSystem, 'SystemContext', 'An example of a System Context diagram.')
        contextView.addAllSoftwareSystems
        contextView.addAllPeople

        styles = views.getConfiguration.getStyles
        styles.addElementStyle(Tags::SOFTWARE_SYSTEM).background('#d34407').color('#ffffff')
        styles.addElementStyle(Tags::PERSON).background('#f86628').color('#ffffff').shape(Shape::Person)
      end
    end
  end
end
