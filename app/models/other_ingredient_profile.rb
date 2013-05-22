class OtherIngredientProfile < ActiveRecord::Base
  belongs_to :recipe
  has_many :ingredient
  validates_uniqueness_of :recipe_id, message: 'That ingredient is already profiled in the related bill'
end