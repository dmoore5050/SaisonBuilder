require_relative '../../bootstrap_ar'

class IngredientController

  attr_reader :question_set
  attr_reader :record

  def initialize(record = nil)
    @question_set = QuestionSet.new
    @record = record
  end

  def create
    ingredient = Ingredient.new(params[:ingredient])
    case
    when ingredient.save then puts 'Success!'
    else puts "Failure: #{ingredient.errors.full_messages.join(", ")}"
    end
  end

  def list_ingredients
    ingredients = Ingredient.all
    puts ' '
    ingredients.each_with_index do | ingredient, i |
      ingredient_name = "#{i + 1}. #{ingredient.name.capitalize}:"
      puts ingredient_name.capitalize.ljust(26) + "#{ingredient.description}"
    end
  end

  def delete
    matching_ingredients = Ingredient.where(name: params[:ingredient][:name]).all
    matching_ingredients.each do |ingredient|
      ingredient.destroy
    end
  end

  def dupont
    # change primary to dupont

    question_set.yeast_redirect_menu
  end

  def french
    # change primary to french

    question_set.yeast_redirect_menu
  end

  def american
    # change primary to american

    question_set.yeast_redirect_menu
  end

  def blend_brett_c
    # add brett as addl primary

    question_set.yeast_redirect_menu
  end

  def blend_brett_b
    # add brett as addl primary

    question_set.yeast_redirect_menu
  end

  def blend_brett_l
    # add brett as addl primary
  end

  def only_brett_c
    # replace primary with brett

    question_set.yeast_redirect_menu
  end

  def only_brett_b
    # replace primary with brett

    question_set.yeast_redirect_menu
  end

  def only_brett_b_trois
    # replace primary with brett

    question_set.yeast_redirect_menu
  end

  def only_brett_l
    # replace primary with brett

    question_set.yeast_redirect_menu
  end

  def secondary_brett_c
    # add brett as secondary

    question_set.yeast_redirect_menu
  end

  def secondary_brett_b
    # add brett as secondary

    question_set.yeast_redirect_menu
  end

  def secondary_brett_l
    # add brett as secondary

    question_set.yeast_redirect_menu
  end

  def caramel
    # add 0.5 lb caramunich 60

    question_set.grain_redirect_menu
  end

  def honey
    # add 0.5 lb honey malt

    question_set.grain_redirect_menu
  end

  def wheat
    # replace 2 lb base malt with wheat

    question_set.grain_redirect_menu
  end

  def rye
    # replace 2 lb base malt with rye

    question_set.grain_redirect_menu
  end

  def brown
    # add 0.4 lbs chocolate malt

    question_set.grain_redirect_menu
  end

  def black
    # add 0.4 lbs chocolate malt/carafa special

    question_set.grain_redirect_menu
  end

  def eight
    # add 1.5 lb base malt, 1 lb sugar

    question_set.gravity_redirect_menu
  end

  def seven
    # add 1.5 lb base malt

    question_set.gravity_redirect_menu
  end

  def five
    # subtract 1.5 lb base malt

    question_set.gravity_redirect_menu
  end

  def four
    # subtract 3 lbs base malt

    question_set.gravity_redirect_menu
  end

  def bitterness
    # add 0.5oz bittering hops 60mins

    question_set.hops_redirect_menu
  end

  def floral_spicy
    # add 1oz hallertau, 15 mins

    question_set.hops_redirect_menu
  end

  def piney_citrus
    # add 1oz amarillo, 15mins

    question_set.hops_redirect_menu
  end

  def floral
    # add 1oz hallertau, dryhop 5 days

    question_set.hops_redirect_menu
  end

  def spicy
    # add 1oz saaz, dryhop 5 days

    question_set.hops_redirect_menu
  end

  def citrus
    # add 1oz amarillo, dryhop 5 days

    question_set.hops_redirect_menu
  end

  def coriander
    # 1oz @ 10 mins boil

    question_set.spices_redirect_menu
  end

  def citrus_zest
    # 1/2 to 1oz, @ 10mins boil

    question_set.spices_redirect_menu
  end

  def white_peppercorns
    # 1/2 tsp @ 5mins boil

    question_set.spices_redirect_menu
  end

  def thai_basil
    # 2oz fresh basil @ 5 mins boil

    question_set.spices_redirect_menu
  end

  def ginger
    # 2 oz fresh grated ginger @ 10mins boil

    question_set.spices_redirect_menu
  end

  def peaches
    # rack beer onto fruit in secondary

    question_set.fruit_redirect_menu
  end

  def blackberries
    # rack beer onto fruit in secondary

    question_set.fruit_redirect_menu
  end

  def mango
    # rack beer onto fruit in secondary

    question_set.fruit_redirect_menu
  end

  def currants
    # rack beer onto fruit in secondary

    question_set.fruit_redirect_menu
  end

  def hibiscus
    # 2oz in secondary

    question_set.botanicals_redirect_menu
  end

  def lavender
    # 1/2oz in secondary

    question_set.botanicals_redirect_menu
  end

  def rose_hips
    # 1/2oz @ 5mins boil

    question_set.botanicals_redirect_menu
  end

  def corn_sugar
    # add sugar to beer at peak krausen

    question_set.adjunct_redirect_menu
  end

  def turbinado_sugar
    # add sugar to beer at peak krausen

    question_set.adjunct_redirect_menu
  end

  def rice
    # precook rice according to instructions, add to mash

    question_set.adjunct_redirect_menu
  end

end