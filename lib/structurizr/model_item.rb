# frozen_string_literal: true

require 'structurizr/metal'

module Structurizr
  ModelItem = Metal::Model::ModelItem

  class ModelItem
    def tags
      get_tags.split(',')
    end

    def inspect
      class_name = self.class.name.split('::').last
      %(#<Structurizr::#{class_name}(#{name.inspect})>)
    end
  end
end
