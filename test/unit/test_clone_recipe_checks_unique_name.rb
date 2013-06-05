require_relative '../test_helper'

class TestCloneRecipeChecksUniqueName < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_error_message_sets_recipe_attributes_if_name_unique
    recipe = Recipe.create(name: 'George', description: 'Pretty good')
    expected = 'George + Pretty good'
    actual = recipe.name + ' + ' + recipe.description
    assert_equal expected, actual

    new_name = 'Frank'
    new_description = 'Not Bad'
    new_expected = new_name + ' + ' + new_description
    RecipeClone.confirm_unique_name new_name, recipe, new_description, nil
    assert_equal new_expected, recipe.name + ' + ' + recipe.description
  end

end