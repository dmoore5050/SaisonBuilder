require_relative '../test_helper'

class TestAddingRecipe < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_takes_arguments_and_saves_them
    assert_equal 2, Recipe.count
    `ruby saisonbuilder add recipe foo`
    assert_equal 3, Recipe.count
  end

  def test_takes_arguments_and_uses_them
    `ruby saisonbuilder add recipe foo`
    assert_equal 'foo', Recipe.last.name
  end

  def test_duplicate_names_are_ignored
    Recipe.create(name: 'foo')
    original_recipe_count = Recipe.count
    `ruby saisonbuilder add recipe foo`
    assert_equal original_recipe_count, Recipe.count
  end

  def test_duplicate_names_outputs_error_message
    Recipe.create(name: 'foo')
    results = `ruby saisonbuilder add recipe foo`
    assert results.include?(' is already assigned'), "Actually was '#{results}'"
  end

end