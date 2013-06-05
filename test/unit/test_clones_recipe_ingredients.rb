require_relative '../test_helper'

class TestClonesRecipeIngredients < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_clones_ingredients_properly
    base_recipe = Recipe.where(name: 'classic').first
    new_recipe = base_recipe.dup
    new_recipe[:name] = 'cloned classic'
    new_recipe.save

    initial_ingredients = new_recipe.recipe_ingredients.all

    assert initial_ingredients.empty?

    RecipeClone.clone_recipe_ingredients base_recipe, new_recipe
    cloned_ingredients = new_recipe.recipe_ingredients.all

    refute cloned_ingredients.empty?

    base_count = base_recipe.recipe_ingredients.count
    clone_count = new_recipe.recipe_ingredients.count

    assert_equal base_count, clone_count

  end

end