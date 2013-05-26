require_relative '../../bootstrap_ar'

class IngredientController

  attr_reader :question_set
  attr_reader :record

  def initialize(record = nil)
    @record = record
    @question_set = QuestionSet.new(record)
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
    primary_yeast = RecipeIngredient.where(recipe_id: @record, usage: 'primary').first
    usage, quantity, duration =  primary_yeast.usage, primary_yeast.quantity, primary_yeast.duration
    primary_yeast.destroy

    ingr = Ingredient.where(name: 'dupont strain').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: usage, quantity: quantity, duration: duration)

    question_set.yeast_redirect_menu
  end

  def french
    primary_yeast = RecipeIngredient.where(recipe_id: @record, usage: 'primary').first
    usage, quantity, duration =  primary_yeast.usage, primary_yeast.quantity, primary_yeast.duration
    primary_yeast.destroy

    ingr = Ingredient.where(name: 'french saison').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: usage, quantity: quantity, duration: duration)

    question_set.yeast_redirect_menu
  end

  def american
    primary_yeast = RecipeIngredient.where(recipe_id: @record, usage: 'primary').first
    usage, quantity, duration =  primary_yeast.usage, primary_yeast.quantity, primary_yeast.duration
    primary_yeast.destroy

    ingr = Ingredient.where(name: 'american farmhouse').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: usage, quantity: quantity, duration: duration)

    question_set.yeast_redirect_menu
  end

  def blend_brett_c
    ingr = Ingredient.where(name: 'brett. clausenii').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'primary', quantity: '1', duration: nil)

    question_set.yeast_redirect_menu
  end

  def blend_brett_b
    ingr = Ingredient.where(name: 'brett. brux.').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'primary', quantity: '1', duration: nil)

    question_set.yeast_redirect_menu
  end

  def blend_brett_l
    ingr = Ingredient.where(name: 'brett. lambicus').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'primary', quantity: '1', duration: nil)

    question_set.yeast_redirect_menu
  end

  def only_brett_c
    primary_yeast = RecipeIngredient.where(recipe_id: @record, usage: 'primary').first
    usage, quantity, duration =  primary_yeast.usage, primary_yeast.quantity, primary_yeast.duration
    primary_yeast.destroy

    ingr = Ingredient.where(name: 'brett. clausenii').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: usage, quantity: quantity, duration: duration)

    question_set.yeast_redirect_menu
  end

  def only_brett_b
    primary_yeast = RecipeIngredient.where(recipe_id: @record, usage: 'primary').first
    usage, quantity, duration =  primary_yeast.usage, primary_yeast.quantity, primary_yeast.duration
    primary_yeast.destroy

    ingr = Ingredient.where(name: 'brett. brux.').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: usage, quantity: quantity, duration: duration)

    question_set.yeast_redirect_menu
  end

  def only_brett_b_trois
    primary_yeast = RecipeIngredient.where(recipe_id: @record, usage: 'primary').first
    usage, quantity, duration =  primary_yeast.usage, primary_yeast.quantity, primary_yeast.duration
    primary_yeast.destroy

    ingr = Ingredient.where(name: 'brett. brux. trois').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: usage, quantity: quantity, duration: duration)

    question_set.yeast_redirect_menu
  end

  def only_brett_l
    primary_yeast = RecipeIngredient.where(recipe_id: @record, usage: 'primary').first
    usage, quantity, duration =  primary_yeast.usage, primary_yeast.quantity, primary_yeast.duration
    primary_yeast.destroy

    ingr = Ingredient.where(name: 'brett. lambicus').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: usage, quantity: quantity, duration: duration)

    question_set.yeast_redirect_menu
  end

  def secondary_brett_c
    ingr = Ingredient.where(name: 'brett. clausenii').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'secondary', quantity: '1', duration: nil)

    question_set.yeast_redirect_menu
  end

  def secondary_brett_b
    ingr = Ingredient.where(name: 'brett. brux.').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'secondary', quantity: '1', duration: nil)

    question_set.yeast_redirect_menu
  end

  def secondary_brett_l
    ingr = Ingredient.where(name: 'brett. lambicus').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'secondary', quantity: '1', duration: nil)

    question_set.yeast_redirect_menu
  end

  def caramel
    ingr = Ingredient.where(name: 'caramunich').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: nil, quantity: '0.5', duration: nil)

    question_set.grain_redirect_menu
  end

  def honey
    ingr = Ingredient.where(name: 'honey malt').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: nil, quantity: '0.5', duration: nil)

    question_set.grain_redirect_menu
  end

  def wheat
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first
    base_malt.quantity -= 2
    base_malt.save

    ingr = Ingredient.where(name: 'white wheat malt').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: nil, quantity: '2', duration: nil)


    question_set.grain_redirect_menu
  end

  def rye
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first
    base_malt.quantity -= 2
    base_malt.save

    ingr = Ingredient.where(name: 'rye malt').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: nil, quantity: '2', duration: nil)

    question_set.grain_redirect_menu
  end

  def brown
    ingr = Ingredient.where(name: 'chocolate malt').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: nil, quantity: '0.4', duration: nil)

    question_set.grain_redirect_menu
  end

  def black
    ingr = Ingredient.where(name: 'chocolate malt').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: nil, quantity: '0.4', duration: nil)
    addl_ingr = Ingredient.where(name: 'carafa 2 special').first
    @record.recipe_ingredients.create(ingredient_id: addl_ingr, usage: nil, quantity: '0.4', duration: nil)


    question_set.grain_redirect_menu
  end

  def eight
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first
    base_malt.quantity += 1.5
    base_malt.save

    sugar = RecipeIngredient.where(recipe_id: @record.id, ingredient_id: 36..37).first
    if sugar.nil?
      ingr = Ingredient.where(name: 'corn sugar').first
      @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'Peak krausen', quantity: '2', duration: nil)
    else
      sugar.quantity += 1
      sugar.save
    end

    question_set.gravity_redirect_menu
  end

  def seven
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first
    base_malt.quantity += 1.5
    base_malt.save

    question_set.gravity_redirect_menu
  end

  def five
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first
    base_malt.quantity -= 1.5
    base_malt.save

    question_set.gravity_redirect_menu
  end

  def four
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first
    base_malt.quantity -= 3
    base_malt.save

    question_set.gravity_redirect_menu
  end

  def bitterness
    ingr = Ingredient.where(name: 'styrian goldings').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'boil', quantity: '0.5', duration: '60 min')

    question_set.hops_redirect_menu
  end

  def floral_spicy
    ingr = Ingredient.where(name: 'hallertau').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'boil', quantity: '1', duration: '20 min')

    question_set.hops_redirect_menu
  end

  def piney_citrus
    ingr = Ingredient.where(name: 'simcoe').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'boil', quantity: '0.5', duration: '20 min')

    question_set.hops_redirect_menu
  end

  def floral
    ingr = Ingredient.where(name: 'hallertau').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'dryhop', quantity: '1', duration: '5 days')

    question_set.hops_redirect_menu
  end

  def spicy
    ingr = Ingredient.where(name: 'saaz').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'dryhop', quantity: '1', duration: '5 days')

    question_set.hops_redirect_menu
  end

  def citrus
    ingr = Ingredient.where(name: 'amarillo').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'dryhop', quantity: '1', duration: '5 days')

    question_set.hops_redirect_menu
  end

  def coriander
    ingr = Ingredient.where(name: 'coriander').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'boil', quantity: '1', duration: '10 min')

    question_set.spices_redirect_menu
  end

  def citrus_zest
    ingr = Ingredient.where(name: 'citrus zest').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'boil', quantity: '1', duration: '10 min')

    question_set.spices_redirect_menu
  end

  def white_peppercorns
    ingr = Ingredient.where(name: 'white peppercorns').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'boil', quantity: '0.05', duration: '5 min')

    question_set.spices_redirect_menu
  end

  def thai_basil
    ingr = Ingredient.where(name: 'thai basil').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'boil', quantity: '2', duration: '5 min')

    question_set.spices_redirect_menu
  end

  def ginger
    ingr = Ingredient.where(name: 'ginger').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'boil', quantity: '2', duration: '10 min')

    question_set.spices_redirect_menu
  end

  def peaches
    ingr = Ingredient.where(name: 'peaches').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'secondary', quantity: '5', duration: 'Until fermentation completed')

    question_set.fruit_redirect_menu
  end

  def blackberries
    ingr = Ingredient.where(name: 'blackberries').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'secondary', quantity: '5', duration: 'Until fermentation completed')

    question_set.fruit_redirect_menu
  end

  def mango
    ingr = Ingredient.where(name: 'mango').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'secondary', quantity: '5', duration: 'Until fermentation completed')

    question_set.fruit_redirect_menu
  end

  def currants
    ingr = Ingredient.where(name: 'currants').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'secondary', quantity: '2', duration: 'Until fermentation completed')

    question_set.fruit_redirect_menu
  end

  def hibiscus
    ingr = Ingredient.where(name: 'hibiscus').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'secondary', quantity: '2', duration: '5 days')

    question_set.botanicals_redirect_menu
  end

  def lavender
    ingr = Ingredient.where(name: 'lavender').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'secondary', quantity: '0.5', duration: '5 days')

    question_set.botanicals_redirect_menu
  end

  def rose_hips
    ingr = Ingredient.where(name: 'rose hips').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'boil', quantity: '0.5', duration: '5 min')

    question_set.botanicals_redirect_menu
  end

  def corn_sugar
    ingr = Ingredient.where(name: 'corn sugar').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'Peak krausen', quantity: '1', duration: nil)

    question_set.adjunct_redirect_menu
  end

  def turbinado_sugar
    ingr = Ingredient.where(name: 'turbinado sugar').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'Peak krausen', quantity: '1', duration: nil)

    question_set.adjunct_redirect_menu
  end

  def rice
    ingr = Ingredient.where(name: 'rice').first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: 'Precook, mash', quantity: '1', duration: nil)

    question_set.adjunct_redirect_menu
  end

end