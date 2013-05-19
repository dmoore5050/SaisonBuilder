# require 'rubygems'
# require 'bundler/setup'
# require 'active_record'

class Recipe < ActiveRecord::Base
  validates_uniqueness_of :name, message: "That recipe name is already assigned"
end
