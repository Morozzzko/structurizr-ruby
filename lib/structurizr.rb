# frozen_string_literal: true

require 'ruby-next/language/setup'
RubyNext::Language.setup_gem_load_path

require 'structurizr/version'
require 'structurizr/model_item'
require 'structurizr/workspace'
require 'structurizr/container'
require 'structurizr/component'
require 'structurizr/relationship'
require 'structurizr/software_system'
require 'structurizr/person'

require 'structurizr/enums'
require 'structurizr/documentation_templates'

require 'structurizr/image_utils'

module Structurizr
  class Error < StandardError; end
end
