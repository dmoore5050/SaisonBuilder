require 'coveralls'
Coveralls.wear!

require 'test/unit'
require_relative '../bootstrap_ar'

connect_to 'test'

ENV['FP_ENV'] = 'test'

module DatabaseCleaner
  def before_setup
    super
    Recipe.destroy_all
    Ingredient.destroy_all
    RecipeIngredient.destroy_all
    load 'db/test_seeds.rb'
  end
end