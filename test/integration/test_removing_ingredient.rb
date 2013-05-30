require_relative '../test_helper'

class TestRemovingIngredient < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_remove_single_ingredient
    Ingredient.create(name: 'only child')
    `ruby saisonbuilder delete ingredient "only child"`
    assert Ingredient.count == 14
  end

  def test_remove_particular_ingredient
    Ingredient.create(name: 'a')
    Ingredient.create(name: 'b')
    Ingredient.create(name: 'c')
    assert !Ingredient.where(name: 'b').all.empty?
    `ruby saisonbuilder delete ingredient b`
    assert Ingredient.where(name: 'b').all.empty?
    assert_equal 16, Ingredient.count
  end

  def test_remove_particular_ingredient_doesnt_remove_all
    assert Ingredient.all.count == 14
    Ingredient.create(name: 'a')
    Ingredient.create(name: 'b')
    Ingredient.create(name: 'c')
    assert !Ingredient.where(name: 'b').all.empty?
    `ruby saisonbuilder delete ingredient b`
    assert_equal 16, Ingredient.count
  end
end