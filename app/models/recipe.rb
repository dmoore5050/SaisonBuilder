
class Recipe < ActiveRecord::Base
  validates_uniqueness_of :name, message: 'That recipe name is already assigned'
  has_one :grain_profile
  has_one :hop_profile
  has_one :yeast_profile
  has_one :other_ingredient_profile
end
