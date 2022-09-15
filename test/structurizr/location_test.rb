# frozen_string_literal: true

require 'test_helper'

module Structurizr
  class LocationTest < Minitest::Test
    def test_inspect_external
      assert_equal %{#<Structurizr::Location::External>}, Location::External.inspect
    end

    def test_inspect_internal
      assert_equal %{#<Structurizr::Location::Internal>}, Location::Internal.inspect
    end

    def test_inspect_unspecified
      assert_equal %{#<Structurizr::Location::Unspecified>}, Location::Unspecified.inspect
    end
  end
end
