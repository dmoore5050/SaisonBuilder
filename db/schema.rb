# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130521220000) do

  create_table "grain_profiles", :force => true do |t|
    t.integer "recipe_id"
    t.integer "quantity"
  end

  create_table "hop_profiles", :force => true do |t|
    t.integer "recipe_id"
    t.integer "quantity"
    t.string  "usage"
    t.string  "duration"
  end

  create_table "ingredients", :force => true do |t|
    t.string  "name"
    t.string  "description"
    t.integer "type_code"
    t.integer "yeast_code_wyeast"
    t.integer "yeast_code_wl"
    t.integer "grain_profile_id"
    t.integer "hop_profile_id"
    t.integer "yeast_profile_id"
    t.integer "other_ingredient_profile_id"
  end

  create_table "other_ingredient_profiles", :force => true do |t|
    t.integer "recipe_id"
    t.integer "quantity"
    t.string  "usage"
  end

  create_table "recipes", :force => true do |t|
    t.string "name"
    t.string "boil_length"
    t.string "primary_fermentation_temp"
  end

  create_table "yeast_profiles", :force => true do |t|
    t.integer "recipe_id"
    t.string  "usage"
  end

end
