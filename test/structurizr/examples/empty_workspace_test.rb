# frozen_string_literal: true

###
# An example of uploading an empty workspace, for when you want to use
# Structurizr's local storage mode.
# Source: https://github.com/structurizr/java/blob/fec199d501b5f670d56e11fb3bf5edc8fe44acaf/structurizr-examples/src/com/structurizr/example/EmptyWorkspace.java
# Updated at: 2017-07-09
module Structurizr
  module Examples
    class EmptyWorkspace < Minitest::Test
      def test_definition
        workspace = Workspace.new('Name', 'Description')
      end
    end
  end
end
