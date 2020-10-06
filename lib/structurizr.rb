# frozen_string_literal: true

require 'structurizr/version'
require 'structurizr/workspace'

# Enums
require 'structurizr/interaction_style'
require 'structurizr/location'
require 'structurizr/paper_size'
require 'structurizr/tags'
require 'structurizr/shape'
require 'structurizr/border'
require 'structurizr/format'
require 'structurizr/routing'
require 'structurizr/filter_mode'

# documentation
require 'structurizr/structurizr_documentation_template'
require 'structurizr/arc42_documentation_template'
require 'structurizr/automatic_documentation_template'
require 'structurizr/viewpoints_and_perspectives_documentation_template'

require 'structurizr/image_utils'

module Structurizr
  class Error < StandardError; end
end
