require_relative '../../bootstrap_ar'

class RecordModification

  attr_reader :record, :next_question

  def initialize(record = nil)
    @record = record
    @next_question = QuestionView.new record
  end

  def describe(type, name, description)
    case type
    when 'ingredient' then record_match = Ingredient.where(name: name)
    when 'recipe' then record_match = Recipe.where(name: name)
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

  def switch_yeast(name)
    primary_yeast = record.recipe_ingredients.where(usage: 'primary').first
    usage, quantity =  primary_yeast.usage, primary_yeast.quantity
    primary_yeast.destroy

    add_new_ingredient name, usage, quantity
  end

  def change_primary(answer, trackback)
    case answer
    when 'dupont'   then yeast = 'dupont strain'
    when 'french'   then yeast = 'french saison'
    when 'american' then yeast = 'american farmhouse'
    else repeat_question answer, trackback
    end

    switch_yeast yeast
    next_question.yeast_redirect_menu
  end

  def repeat_question(answer, trackback)
    puts "\n'#{answer}' is not a valid option. Please choose from the choices listed."
    puts "Type 'Menu' to return to Recipes menu, or 'Quit' to exit SaisonBuilder."
    repeat_question = QuestionView.new record
    repeat_question.send("#{trackback}")
  end

  def add_brett(answer, trackback, yeast_usage)
    case answer
    when 'brett c' then name = 'brett. clausenii'
    when 'brett b' then name = 'brett. brux.'
    when 'brett l' then name = 'brett. lambicus'
    else repeat_question answer, trackback
    end
    usage, quantity = yeast_usage, 1

    add_new_ingredient name, usage, quantity
    next_question.yeast_redirect_menu
  end

  def brett_primary(answer, trackback)
    case answer
    when 'brett c'       then name = 'brett. clausenii'
    when 'brett b'       then name = 'brett. brux.'
    when 'brett b trois' then name = 'brett. brux. trois'
    when 'brett l'       then name = 'brett. lambicus'
    else repeat_question answer, trackback
    end

    switch_primary_yeast name
    next_question.yeast_redirect_menu
  end

  def add_sweetness(answer, trackback)
    case answer
    when 'caramel' then name = 'caramunich'
    when 'honey'   then name = 'honey malt'
    else repeat_question answer, trackback
    end
    usage, quantity = nil, 0.5

    add_new_ingredient name, usage, quantity
    next_question.grain_redirect_menu
  end

  def add_base_grain(answer, trackback)
    case answer
    when 'wheat' then args = [['wheat malt', nil, 3], ['rice hulls', nil, 0.2]]
    when 'rye'   then args = [['rye malt', nil, 3], ['rice hulls', nil, 0.2]]
    else repeat_question answer, trackback
    end

    args.each do | argument_set |
      name, usage, quantity = argument_set
      add_new_ingredient name, usage, quantity
    end
    next_question.grain_redirect_menu
  end

  def add_roast(answer, trackback)
    case answer
    when 'brown'
      args = [
        ['chocolate malt', nil, 0.4],
        ['flaked oats', nil, 1]
      ]
    when 'black'
      args = [
        ['chocolate malt', nil, 0.4],
        ['carafa 2 special', nil, 0.4],
        ['flaked oats', nil, 1]
      ]
    else repeat_question answer, trackback
    end

    args.each do | argument_set |
      name, usage, quantity = argument_set
      add_new_ingredient name, usage, quantity
    end
    next_question.grain_redirect_menu
  end

  def change_gravity(answer, trackback)
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first

    case answer
    when 'eight'
     quantity_adjustment = base_malt.quantity + 1.5
     sugar = RecipeIngredient.where(recipe_id: @record, ingredient_id: 38..39).first
     add_sugar_to_recipe sugar
    when 'seven' then quantity_adjustment = base_malt.quantity + 1.5
    when 'five'  then quantity_adjustment = base_malt.quantity - 1.5
    when 'four'  then quantity_adjustment = base_malt.quantity - 3
    else repeat_question answer, trackback
    end

    base_malt.update_attributes(quantity: quantity_adjustment)

    next_question.gravity_redirect_menu
  end

  def add_sugar_to_recipe(sugar)
    if sugar.nil?
      name, usage, quantity = 'corn sugar', 'Peak krausen', 2

      add_new_ingredient name, usage, quantity
    else
      sugar.quantity += 1
      sugar.save
    end
  end

  # ***********************************
  #          progress marker
  # ***********************************

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