
class Recipe < ActiveRecord::Base

  validates_uniqueness_of :name, message: 'is already assigned'
  validates_presence_of :name, message: 'is required to create a new Recipe'
  validates_length_of :name, maximum: 20,
    too_long: "length must be 20 or fewer characters"
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

end