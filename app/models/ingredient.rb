
class Ingredient < ActiveRecord::Base
  validates_uniqueness_of :name, message: "That ingredient name is already assigned"
  belongs_to :grain_profile
  belongs_to :hop_profile
  belongs_to :yeast_profile
  belongs_to :other_ingredient_profile
end