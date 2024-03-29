# frozen_string_literal: true

require 'java'

require 'structurizr_jars'

module Structurizr
  # This namespace provides lower-level Java integration with Structurizr
  module Metal
    Root = ::Java::ComStructurizr
    Model = ::Java::ComStructurizrModel
    View = ::Java::ComStructurizrView
    Client = ::Java::ComStructurizrClient
    Util = ::Java::ComStructurizrUtil
    Documentation = ::Java::ComStructurizrDocumentation

    # We need it due to a behavior in jruby which doesn't bind methods from non-public classes
    # https://github.com/jruby/jruby/issues/6197
    # For now we'll stick to our own patch which manually binds those methods
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
