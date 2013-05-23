
class Ingredient < ActiveRecord::Base
  validates_uniqueness_of :name, message: 'That ingredient name is already assigned'
  validates_presence_of :name, message: 'That ingredient requires a name'
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
end