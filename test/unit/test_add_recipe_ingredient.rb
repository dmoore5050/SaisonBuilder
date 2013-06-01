require_relative '../test_helper'

class TestAddingRecipeIngredient < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_add_recipe_ingredient_takes_arguments_and_saves_them
    assert_equal 16, RecipeIngredient.count
    RecipeIngredient.create(quantity: 1)
    assert_equal 17, RecipeIngredient.count
  end

  def test_add_recipe_ingredient_takes_arguments_and_uses_them
    RecipeIngredient.create(quantity: 1)
    assert_equal 1, RecipeIngredient.last.quantity
  end

end