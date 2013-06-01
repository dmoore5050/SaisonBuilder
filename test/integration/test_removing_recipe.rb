require_relative '../test_helper'

class TestRemovingRecipe < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_remove_only_recipe
    Recipe.create(name: 'only child')
    `ruby saisonbuilder delete recipe "only child"`
    assert Recipe.count == 2
  end

  def test_remove_particular_recipe
    Recipe.create(name: 'a')
    Recipe.create(name: 'b')
    Recipe.create(name: 'c')
    refute Recipe.where(name: 'b').all.empty?
    `ruby saisonbuilder delete recipe b`
    assert Recipe.where(name: 'b').all.empty?
    assert_equal 4, Recipe.count
  end

  def test_remove_particular_recipe_doesnt_remove_all
    assert Recipe.all.count == 2
    Recipe.create(name: 'a')
    Recipe.create(name: 'b')
    Recipe.create(name: 'c')
    refute Recipe.where(name: 'b').all.empty?
    `ruby saisonbuilder delete recipe b`
    assert_equal 4, Recipe.count
  end
end