
class Recipe < ActiveRecord::Base
  validates_uniqueness_of :name, message: "That recipe name is already assigned"
end
