require_relative '../test_helper'

class TestAddingIngredient < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_add_ingredient_ignores_duplicate_names
    Ingredient.create(name: 'foo')
    original_ingredient_count = Ingredient.count
    `ruby sb add ingredient foo`
    assert_equal original_ingredient_count, Ingredient.count
  end

  def test_duplicate_ingredient_names_outputs_error_message
    Ingredient.create(name: 'foo')
    results = `ruby sb add ingredient foo`
    assert results.include?(' is already assigned'), "Actually was '#{results}'"
  end

  def test_blank_ingredient_name_is_ignored
    original_ingredient_count = Ingredient.count
    `ruby sb add ingredient`
    assert_equal original_ingredient_count, Ingredient.count
  end

  def test_ingredient_name_longer_than_20_chars_is_ignored
    original_ingredient_count = Ingredient.count
    `ruby sb add ingredient thisisareallylongingredientname`
    assert_equal original_ingredient_count, Ingredient.count
  end

  def test_ingredient_name_longer_than_20_chars_outputs_error_message
    results = `ruby sb add ingredient thisisareallylongingredientname`
    assert results.include?(' length must be 20 or fewer characters'), "Actually was '#{results}'"
  end

end