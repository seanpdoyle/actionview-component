# frozen_string_literal: true

require "test_helper"
require "rails/generators/test_case"
require "rails/generators/slim/component_generator"

Rails.application.load_generators

class SlimGeneratorTest < Rails::Generators::TestCase
  tests Slim::Generators::ComponentGenerator
  destination File.expand_path("../tmp", __dir__)
  setup :prepare_destination

  arguments %w[user]

  def test_component_with_required_content
    run_generator %w[user --require-content]

    assert_file "app/components/user_component.html.slim" do |view|
      assert_match(/= content/, view)
    end
  end

  def test_component_without_required_content
    run_generator

    assert_file "app/components/user_component.html.slim" do |view|
      assert_match(/div Add User template here/, view)
    end
  end

  def test_component_with_namespace
    run_generator %w[admins/user]

    assert_file "app/components/admins/user_component.html.slim"
  end
end
