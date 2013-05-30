
class Recipe < ActiveRecord::Base
  validates_uniqueness_of :name, message: 'is already assigned'
  validates_presence_of :name, message: 'is required to create a new Recipe'
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
end
