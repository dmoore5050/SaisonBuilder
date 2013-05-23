require_relative '../test_helper'

class TestRemovingRecipe < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_remove_only_recipe
    Recipe.create(name: 'only child')
    `ruby saisonbuilder delete "only child"`
    assert Recipe.all.empty?
  end

  def test_remove_particular_recipe
    Recipe.create(name: 'a')
    Recipe.create(name: 'b')
    Recipe.create(name: 'c')
    assert !Recipe.where(name: 'b').all.empty?
    `ruby saisonbuilder delete b`
    assert Recipe.where(name: 'b').all.empty?
    assert_equal 2, Recipe.count
  end

  def test_remove_particular_recipe_doesnt_remove_all
    assert Recipe.all.empty?
    Recipe.create(name: 'a')
    Recipe.create(name: 'b')
    Recipe.create(name: 'c')
    assert !Recipe.where(name: 'b').all.empty?
    `ruby saisonbuilder delete b`
    assert_equal 2, Recipe.count
  end
end