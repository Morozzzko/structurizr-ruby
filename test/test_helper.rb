# frozen_string_literal: true

require 'simplecov'
require 'pry'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'structurizr'

require 'minitest/autorun'
