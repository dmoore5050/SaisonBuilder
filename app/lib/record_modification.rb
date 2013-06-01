require_relative '../../bootstrap_ar'

class RecordModification

  attr_reader :record, :next_question

  def initialize(record = nil)
    @record = record
    @next_question = QuestionView.new record
  end

  def describe(type, name, description)
    case type
    when 'ingredient' then record_match = Ingredient.where(name: name).first
    when 'recipe' then record_match = Recipe.where(name: name).first
    end

    record_match.update_attributes(description: description)
  end

  def remove(name, usage, duration)
    matching_ingr = Ingredient.where(name: name)
    dropped_ingredient = RecipeIngredient.where(recipe_id: @record, ingredient_id: matching_ingr, usage: usage, duration: duration).first
    dropped_ingredient.destroy

    next_question.remove_redirect_menu
  end

  def add_new_ingredient(name, usage, quantity, duration = nil)
    ingr = Ingredient.where(name: name).first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: usage, quantity: quantity, duration: duration)
  end

  def switch_primary_yeast(name)
    primary_yeast = RecipeIngredient.where(recipe_id: @record, usage: 'primary').first
    usage, quantity =  primary_yeast.usage, primary_yeast.quantity
    primary_yeast.destroy

    add_new_ingredient name, usage, quantity
  end

  def dupont
    new_primary_yeast = 'dupont strain'

    switch_primary_yeast new_primary_yeast
    next_question.yeast_redirect_menu
  end

  def french
    new_primary_yeast = 'french saison'

    switch_primary_yeast new_primary_yeast
    next_question.yeast_redirect_menu
  end

  def american
    new_primary_yeast = 'american farmhouse'

    switch_primary_yeast new_primary_yeast
    next_question.yeast_redirect_menu
  end

  def blend_brett_c
    name, usage, quantity = 'brett. clausenii', 'primary', 1

    add_new_ingredient name, usage, quantity
    next_question.yeast_redirect_menu
  end

  def blend_brett_b
    name, usage, quantity = 'brett. brux.', 'primary', 1

    add_new_ingredient name, usage, quantity
    next_question.yeast_redirect_menu
  end

  def blend_brett_l
    name, usage, quantity = 'brett. lambicus', 'primary', 1

    add_new_ingredient name, usage, quantity
    next_question.yeast_redirect_menu
  end

  def only_brett_c
    new_primary_yeast = 'brett. clausenii'

    switch_primary_yeast new_primary_yeast
    next_question.yeast_redirect_menu
  end

  def only_brett_b
    new_primary_yeast = 'brett. brux.'

    switch_primary_yeast new_primary_yeast
    next_question.yeast_redirect_menu
  end

  def only_brett_b_trois
    new_primary_yeast = 'brett. brux. trois'

    switch_primary_yeast new_primary_yeast
    next_question.yeast_redirect_menu
  end

  def only_brett_l
    new_primary_yeast = 'brett. lambicus'

    switch_primary_yeast new_primary_yeast
    next_question.yeast_redirect_menu
  end

  def secondary_brett_c
    name, usage, quantity = 'brett. clausenii', 'secondary', 1

    add_new_ingredient name, usage, quantity
    next_question.yeast_redirect_menu
  end

  def secondary_brett_b
    name, usage, quantity = 'brett. brux.', 'secondary', 1

    add_new_ingredient name, usage, quantity
    next_question.yeast_redirect_menu
  end

  def secondary_brett_l
    name, usage, quantity = 'brett. lambicus', 'secondary', 1

    add_new_ingredient name, usage, quantity
    next_question.yeast_redirect_menu
  end

  def caramel
    name, usage, quantity = 'caramunich', nil, 0.5

    add_new_ingredient name, usage, quantity
    next_question.grain_redirect_menu
  end

  def honey
    name, usage, quantity = 'honey malt', nil, 0.5

    add_new_ingredient name, usage, quantity
    next_question.grain_redirect_menu
  end

  def wheat
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first
    base_malt.update_attributes(quantity: base_malt.quantity - 3)

    args = [['wheat malt', nil, 3], ['rice hulls', nil, 0.2]]

    args.each do | argument_set |
      name, usage, quantity = argument_set
      add_new_ingredient name, usage, quantity
    end
    next_question.grain_redirect_menu
  end

  def rye
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first
    base_malt.update_attributes(quantity: base_malt.quantity - 3)

    args = [['rye malt', nil, 3], ['rice hulls', nil, 0.2]]

    args.each do | argument_set |
      name, usage, quantity = argument_set
      add_new_ingredient name, usage, quantity
    end
    next_question.grain_redirect_menu
  end

  def brown
    name, usage, quantity = [['chocolate malt', nil, 0.4], ['flaked oats', nil, 1]]

    args.each do | argument_set |
      name, usage, quantity = argument_set
      add_new_ingredient name, usage, quantity
    end
    next_question.grain_redirect_menu
  end

  def black
    args = [['chocolate malt', nil, 0.4], ['carafa 2 special', nil, 0.4], ['flaked oats', nil, 1]]

    args.each do | argument_set |
      name, usage, quantity = argument_set
      add_new_ingredient name, usage, quantity
    end
    next_question.grain_redirect_menu
  end

  def eight
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first
    base_malt.update_attributes(quantity: base_malt.quantity + 1.5)

    sugar = RecipeIngredient.where(recipe_id: @record.id, ingredient_id: 36..37).first
    add_addl_sugar_to_recipe sugar

    next_question.gravity_redirect_menu
  end

  def add_addl_sugar_to_recipe(sugar)
    if sugar.nil?
      name, usage, quantity = 'corn sugar', 'Peak krausen', 2

      add_new_ingredient name, usage, quantity
    else
      sugar.quantity += 1
      sugar.save
    end
  end

  def seven
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first
    base_malt.update_attributes(quantity: base_malt.quantity + 1.5)

    next_question.gravity_redirect_menu
  end

  def five
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first
    base_malt.update_attributes(quantity: base_malt.quantity - 1.5)

    next_question.gravity_redirect_menu
  end

  def four
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first
    base_malt.update_attributes(quantity: base_malt.quantity - 3)

    next_question.gravity_redirect_menu
  end

  def bittering
    name, usage, quantity, duration = 'styrian goldings', 'boil', 0.5, '60 min'

    add_new_ingredient name, usage, quantity, duration
    next_question.hops_redirect_menu
  end

  def floral_spicy
    name, usage, quantity, duration = 'hallertau', 'boil', 1, '20 min'

    add_new_ingredient name, usage, quantity, duration
    next_question.hops_redirect_menu
  end

  def piney_citrus
    name, usage, quantity, duration = 'simcoe', 'boil', 0.5, '20 min'

    add_new_ingredient name, usage, quantity, duration
    next_question.hops_redirect_menu
  end

  def floral
    name, usage, quantity, duration = 'hallertau', 'dryhop', 1, '5 days'

    add_new_ingredient name, usage, quantity, duration
    next_question.hops_redirect_menu
  end

  def spicy
    name, usage, quantity, duration = 'saaz', 'dryhop', 1, '5 days'

    add_new_ingredient name, usage, quantity, duration
    next_question.hops_redirect_menu
  end

  def citrus
    name, usage, quantity, duration = 'amarillo', 'dryhop', 1, '5 days'

    add_new_ingredient name, usage, quantity, duration
    next_question.hops_redirect_menu
  end

  def coriander
    name, usage, quantity, duration = 'coriander', 'boil', 1, '10 mins'

    add_new_ingredient name, usage, quantity, duration
    next_question.spices_redirect_menu
  end

  def citrus_zest
    name, usage, quantity, duration = 'citrus zest', 'boil', 1, '10 mins'

    add_new_ingredient name, usage, quantity, duration
    next_question.spices_redirect_menu
  end

  def white_peppercorns
    name, usage, quantity, duration = 'white peppercorns', 'boil', 0.05, '5 mins'

    add_new_ingredient name, usage, quantity, duration
    next_question.spices_redirect_menu
  end

  def thai_basil
    name, usage, quantity, duration = 'thai basil', 'boil', 2, '5 mins'

    add_new_ingredient name, usage, quantity, duration
    next_question.spices_redirect_menu
  end

  def ginger
    name, usage, quantity, duration = 'ginger', 'boil', 2, '10 mins'

    add_new_ingredient name, usage, quantity, duration
    next_question.spices_redirect_menu
  end

  def peaches
    name, usage, quantity, duration = 'peaches', 'secondary', 4, 'Until fermentation completed'

    add_new_ingredient name, usage, quantity, duration
    next_question.fruit_redirect_menu
  end

  def blackberries
    name, usage, quantity, duration = 'blackberries', 'secondary', 4, 'Until fermentation completed'

    add_new_ingredient name, usage, quantity, duration
    next_question.fruit_redirect_menu
  end

  def mango
    name, usage, quantity, duration = 'mango', 'secondary', 4, 'Until fermentation completed'

    add_new_ingredient name, usage, quantity, duration
    next_question.fruit_redirect_menu
  end

  def currants
    name, usage, quantity, duration = 'currants', 'secondary', 2, 'Until fermentation completed'

    add_new_ingredient name, usage, quantity, duration
    next_question.fruit_redirect_menu
  end

  def hibiscus
    name, usage, quantity, duration = 'hibiscus', 'secondary', 2, '5 days'

    add_new_ingredient name, usage, quantity, duration
    next_question.botanicals_redirect_menu
  end

  def lavender
    name, usage, quantity, duration = 'lavender', 'secondary', 0.5, '5 days'

    add_new_ingredient name, usage, quantity, duration
    next_question.botanicals_redirect_menu
  end

  def rose_hips
    name, usage, quantity, duration = 'rose hips', 'boil', 0.5, '5 min'

    add_new_ingredient name, usage, quantity, duration
    next_question.botanicals_redirect_menu
  end

  def corn_sugar
    name, usage, quantity = 'corn sugar', 'Peak Krausen', 1

    add_new_ingredient name, usage, quantity
    next_question.adjunct_redirect_menu
  end

  def turbinado_sugar
    name, usage, quantity = 'turbinado sugar', 'Peak Krausen', 1

    add_new_ingredient name, usage, quantity
    next_question.adjunct_redirect_menu
  end

  def rice
    name, usage, quantity = 'rice', 'Precook, mash', 1

    add_new_ingredient name, usage, quantity
    next_question.adjunct_redirect_menu
  end
end