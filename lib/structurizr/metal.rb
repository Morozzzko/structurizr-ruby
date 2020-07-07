# frozen_string_literal: true

require 'java'

require 'structurizr/metal/jars/commons-logging-1.2.jar'
require 'structurizr/metal/jars/structurizr-core-1.4.5.jar'

module Structurizr
  # This namespace provides lower-level Java integration with Structurizr
  module Metal
    Root = ::Java::ComStructurizr
    Model = ::Java::ComStructurizrModel
    Util = ::Java::ComStructurizrUtil
  end
end
