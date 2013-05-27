require 'test/unit'
require_relative '../bootstrap_ar'

connect_to 'test'

ENV['FP_ENV'] = 'test'

module DatabaseCleaner
  def before_setup
    super
    Recipe.destroy_all
    Ingredient.destroy_all
    load "~/desktop/NSS/NSS_section_2/saison_app/db/test_seeds.rb"
  end
end
