require_relative '../test_helper'

class TestAddingIngredient < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_add_ingredient_takes_arguments_and_saves_them
    assert_equal 14, Ingredient.count
    `ruby saisonbuilder add ingredient foo`
    `ruby saisonbuilder ingredients`
    assert_equal 15, Ingredient.count
  end

  def test_add_ingredient_takes_arguments_and_uses_them
    `ruby saisonbuilder add ingredient foo`
    assert_equal 'foo', Ingredient.last.name
  end

  def test_add_ingredient_ignores_duplicate_names
    Ingredient.create(name: 'foo')
    original_ingredient_count = Ingredient.count
    `ruby saisonbuilder add ingredient foo`
    assert_equal original_ingredient_count, Ingredient.count
  end

  def test_duplicate_ingredient_names_outputs_error_message
    Ingredient.create(name: 'foo')
    results = `ruby saisonbuilder add ingredient foo`
    assert results.include?(' is already assigned'), "Actually was '#{results}'"
  end

end