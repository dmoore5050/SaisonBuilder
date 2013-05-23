
class Recipe < ActiveRecord::Base
  validates_uniqueness_of :name, message: 'That recipe name is already assigned'
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
end
