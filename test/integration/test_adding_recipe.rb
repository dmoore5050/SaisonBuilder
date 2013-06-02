require_relative '../test_helper'

class TestAddingRecipe < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_duplicate_names_are_ignored
    Recipe.create(name: 'foo')
    original_recipe_count = Recipe.count
    `ruby sb add recipe foo`
    assert_equal original_recipe_count, Recipe.count
  end

  def test_duplicate_names_outputs_error_message
    Recipe.create(name: 'foo')
    results = `ruby sb add recipe foo`
    assert results.include?(' is already assigned'), "Actually was '#{results}'"
  end

  def test_blank_name_is_ignored
    original_recipe_count = Recipe.count
    `ruby sb add recipe`
    assert_equal original_recipe_count, Recipe.count
  end

  def test_blank_name_outputs_error_message
    results = `ruby sb add recipe`
    assert results.include?(' is required to create a new Recipe'), "Actually was '#{results}'"
  end

  def test_name_longer_than_20_chars_is_ignored
    original_recipe_count = Recipe.count
    `ruby sb add recipe thisisareallylongrecipename`
    assert_equal original_recipe_count, Recipe.count
  end

  def test_name_longer_than_20_chars_outputs_error_message
    results = `ruby sb add recipe thisisareallylongrecipename`
    assert results.include?(' length must be 20 or fewer characters'), "Actually was '#{results}'"
  end

end