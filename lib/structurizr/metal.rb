# frozen_string_literal: true

require 'java'

require 'structurizr/metal/jars/commons-logging-1.2.jar'
require 'structurizr/metal/jars/structurizr-core-1.4.7.jar'
require 'structurizr/metal/jars/structurizr-client-1.4.7.jar'

module Structurizr
  # This namespace provides lower-level Java integration with Structurizr
  module Metal
    Root = ::Java::ComStructurizr
    Model = ::Java::ComStructurizrModel
    View = ::Java::ComStructurizrView
    Client = ::Java::ComStructurizrClient
    Util = ::Java::ComStructurizrUtil

    class Model::ModelItem
      java_alias :addTags, :addTags, [java.lang.String[]]
      java_alias :add_tags, :addTags, [java.lang.String[]]
      java_alias :getTags, :getTags, []
      java_alias :get_tags, :getTags, []
      java_alias :removeTag, :removeTag, [java.lang.String]
      java_alias :remove_tag, :removeTag, [java.lang.String]
      java_alias :hasTag, :hasTag, [java.lang.String]
      java_alias :has_tag, :hasTag, [java.lang.String]
    end
  end
end
