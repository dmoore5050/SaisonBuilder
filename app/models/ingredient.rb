
class Ingredient < ActiveRecord::Base
  validates_uniqueness_of :name, message: "That ingredient name is already assigned"
end