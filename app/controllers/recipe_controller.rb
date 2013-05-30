require_relative '../../bootstrap_ar'

class RecipeController

  def initialize(params, record = nil)
      @params = params
      @record = record
      @question_set = QuestionSet.new record
  end

  def create
    recipe = Recipe.new(params[:recipe])
    case
    when recipe.save then puts 'Success!'
    else puts "Failure: #{recipe.errors.full_messages.join(", ")}"
    end
  end

  def list_recipes
    recipes = Recipe.all
    puts "\n"
    recipes.each_with_index do |recipe, i|
      formatted_name = recipe.name + ':'
      if !recipe.description.nil?
        puts "#{i + 1}. #{formatted_name.titleize.ljust(21)}#{recipe.description.capitalize}"
      else
        puts "#{i + 1}. #{recipe.name.titleize}"
      end
    end
    puts "\nTo view a recipe, type: sb view <recipe name>."
    puts 'Example: sb view black saison'
  end

  def delete
    check_if_name_is_entered
    matching_recipe = Recipe.where(name: params[:recipe][:name].downcase).first
    check_if_name_matches_recipe matching_recipe
    ingr_array = RecipeIngredient.where(recipe_id: matching_recipe.id).all
    ingr_array.each do | recipe_ingredient |
      recipe_ingredient.destroy
    end
    matching_recipe.destroy
    case
    when matching_recipe.destroyed?
      puts "\n#{params[:recipe][:name].titleize} has been deleted."
    else puts "Failure: #{recipe.errors.full_messages.join(", ")}"
    end
  end

  def check_if_name_is_entered
    if params[:recipe][:name].nil?
      puts "\nYou did not specify a recipe name."
      puts 'To view a list of possible recipes, type sb list'
      exit
    end
  end

  def check_if_name_matches_recipe(matching_recipe)
    if matching_recipe.nil?
      puts "\n#{params[:recipe][:name].titleize} is not a valid recipe name."
      puts 'To view a list of possible recipes, type sb list'
      exit
    end
  end

  def view
    check_if_name_is_entered
    matching_recipe = Recipe.where(name: params[:recipe][:name].downcase).first
    check_if_name_matches_recipe matching_recipe
    ingredient_list = RecipeIngredient.where(recipe_id: matching_recipe.id).all
    rendered_recipe = ''
    recipe_head = %Q(
Name:          #{matching_recipe.name.titleize}
Batch size:    5 gallons
Mash:          90 mins @ 149F
Boil length:   #{matching_recipe.boil_length} mins

)
    rendered_recipe << recipe_head

    ingredient_print_order = %w(grain adjunct hop spice fruit botanical yeast)
    ingredient_print_order.each do | type |
      rendered_recipe << render_ingredient_bill(type, ingredient_list)
    end

    recipe_foot = %Q(
Primary Fermentation Temp:  #{matching_recipe.primary_fermentation_temp}
)
    rendered_recipe << recipe_foot
    puts rendered_recipe
  end

  def render_ingredient_bill(match_code, ingredient_list)
    ingredient_bill = ''

    ingredient_list.each do | ingredient |
      ingr_record = Ingredient.where("id = #{ingredient.ingredient_id}").first
      if ingr_record.type_code == match_code
        ingredient_bill << build_line_item(match_code, ingredient, ingr_record)
      end
    end
    ingredient_bill
  end

  def build_line_item(match_code, ingredient, ingr_record)
    measure = quantity_unit match_code
    usage_indicator = ingredient.usage == 'boil' ? '@ ' : nil
    line_item = "#{ingredient.quantity} #{measure} #{ingr_record.name.titleize}".ljust(28)
    line_item << "Add during: #{ingredient.usage.capitalize}" unless ingredient.usage.nil?
    line_item << ", #{usage_indicator}#{ingredient.duration}" unless ingredient.duration.nil?
    line_item << ". Mfg. code(s): White Labs WLP#{ingr_record.yeast_code_wl}" unless ingr_record.yeast_code_wl.nil?
    line_item << ", Wyeast #{ingr_record.yeast_code_wyeast}" unless ingr_record.yeast_code_wyeast.nil?
    line_item << "\n"
  end

  def quantity_unit(match_code)
    case match_code
    when 'hop' || 'spice' || 'botanicals' then 'oz'
    when 'yeast' then 'pkg'
    else 'lbs'
    end
  end

  def remove(name, usage, duration)
    matching_ingr = Ingredient.where(name: name)
    dropped_ingredient = RecipeIngredient.where(recipe_id: @record, ingredient_id: matching_ingr, usage: usage, duration: duration).first
    dropped_ingredient.destroy

    question_set.remove_redirect_menu
  end

  def switch_primary_yeast(name)
    primary_yeast = RecipeIngredient.where(recipe_id: @record, usage: 'primary').first
    usage, quantity =  primary_yeast.usage, primary_yeast.quantity
    primary_yeast.destroy

    add_new_ingredient name, usage, quantity
  end

  def add_new_ingredient(name, usage, quantity, duration = nil)
    ingr = Ingredient.where(name: name).first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: usage, quantity: quantity, duration: duration)
  end

  def dupont
    new_primary_yeast = 'dupont strain'

    switch_primary_yeast new_primary_yeast
    question_set.yeast_redirect_menu
  end

  def french
    new_primary_yeast = 'french saison'

    switch_primary_yeast new_primary_yeast
    question_set.yeast_redirect_menu
  end

  def american
    new_primary_yeast = 'american farmhouse'

    switch_primary_yeast new_primary_yeast
    question_set.yeast_redirect_menu
  end

  def blend_brett_c
    name, usage, quantity = 'brett. clausenii', 'primary', 1

    add_new_ingredient name, usage, quantity
    question_set.yeast_redirect_menu
  end

  def blend_brett_b
    name, usage, quantity = 'brett. brux.', 'primary', 1

    add_new_ingredient name, usage, quantity
    question_set.yeast_redirect_menu
  end

  def blend_brett_l
    name, usage, quantity = 'brett. lambicus', 'primary', 1

    add_new_ingredient name, usage, quantity
    question_set.yeast_redirect_menu
  end

  def only_brett_c
    new_primary_yeast = 'brett. clausenii'

    switch_primary_yeast new_primary_yeast
    question_set.yeast_redirect_menu
  end

  def only_brett_b
    new_primary_yeast = 'brett. brux.'

    switch_primary_yeast new_primary_yeast
    question_set.yeast_redirect_menu
  end

  def only_brett_b_trois
    new_primary_yeast = 'brett. brux. trois'

    switch_primary_yeast new_primary_yeast
    question_set.yeast_redirect_menu
  end

  def only_brett_l
    new_primary_yeast = 'brett. lambicus'

    switch_primary_yeast new_primary_yeast
    question_set.yeast_redirect_menu
  end

  def secondary_brett_c
    name, usage, quantity = 'brett. clausenii', 'secondary', 1

    add_new_ingredient name, usage, quantity
    question_set.yeast_redirect_menu
  end

  def secondary_brett_b
    name, usage, quantity = 'brett. brux.', 'secondary', 1

    add_new_ingredient name, usage, quantity
    question_set.yeast_redirect_menu
  end

  def secondary_brett_l
    name, usage, quantity = 'brett. lambicus', 'secondary', 1

    add_new_ingredient name, usage, quantity
    question_set.yeast_redirect_menu
  end

  def caramel
    name, usage, quantity = 'caramunich', nil, 0.5

    add_new_ingredient name, usage, quantity
    question_set.grain_redirect_menu
  end

  def honey
    name, usage, quantity = 'honey malt', nil, 0.5

    add_new_ingredient name, usage, quantity
    question_set.grain_redirect_menu
  end

  def wheat
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first
    base_malt.quantity -= 3
    base_malt.save

    args = [['wheat malt', nil, 3], ['rice hulls', nil, 0.2]]

    args.each do | argument_set |
      name, usage, quantity = argument_set
      add_new_ingredient name, usage, quantity
    end
    question_set.grain_redirect_menu
  end

  def rye
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first
    base_malt.quantity -= 3
    base_malt.save

    args = [['rye malt', nil, 3], ['rice hulls', nil, 0.2]]

    args.each do | argument_set |
      name, usage, quantity = argument_set
      add_new_ingredient name, usage, quantity
    end
    question_set.grain_redirect_menu
  end

  def brown
    name, usage, quantity = [['chocolate malt', nil, 0.4], ['flaked oats', nil, 1]]

    args.each do | argument_set |
      name, usage, quantity = argument_set
      add_new_ingredient name, usage, quantity
    end
    question_set.grain_redirect_menu
  end

  def black
    args = [['chocolate malt', nil, 0.4], ['carafa 2 special', nil, 0.4], ['flaked oats', nil, 1]]

    args.each do | argument_set |
      name, usage, quantity = argument_set
      add_new_ingredient name, usage, quantity
    end
    question_set.grain_redirect_menu
  end

  def eight
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first
    base_malt.quantity += 1.5
    base_malt.save

    sugar = RecipeIngredient.where(recipe_id: @record.id, ingredient_id: 36..37).first
    if sugar.nil?
      name, usage, quantity = 'corn sugar', 'Peak krausen', 2

      add_new_ingredient name, usage, quantity
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

  def bittering
    name, usage, quantity, duration = 'styrian goldings', 'boil', 0.5, '60 min'

    add_new_ingredient name, usage, quantity, duration
    question_set.hops_redirect_menu
  end

  def floral_spicy
    name, usage, quantity, duration = 'hallertau', 'boil', 1, '20 min'

    add_new_ingredient name, usage, quantity, duration
    question_set.hops_redirect_menu
  end

  def piney_citrus
    name, usage, quantity, duration = 'simcoe', 'boil', 0.5, '20 min'

    add_new_ingredient name, usage, quantity, duration
    question_set.hops_redirect_menu
  end

  def floral
    name, usage, quantity, duration = 'hallertau', 'dryhop', 1, '5 days'

    add_new_ingredient name, usage, quantity, duration
    question_set.hops_redirect_menu
  end

  def spicy
    name, usage, quantity, duration = 'saaz', 'dryhop', 1, '5 days'

    add_new_ingredient name, usage, quantity, duration
    question_set.hops_redirect_menu
  end

  def citrus
    name, usage, quantity, duration = 'amarillo', 'dryhop', 1, '5 days'

    add_new_ingredient name, usage, quantity, duration
    question_set.hops_redirect_menu
  end

  def coriander
    name, usage, quantity, duration = 'coriander', 'boil', 1, '10 mins'

    add_new_ingredient name, usage, quantity, duration
    question_set.spices_redirect_menu
  end

  def citrus_zest
    name, usage, quantity, duration = 'citrus zest', 'boil', 1, '10 mins'

    add_new_ingredient name, usage, quantity, duration
    question_set.spices_redirect_menu
  end

  def white_peppercorns
    name, usage, quantity, duration = 'white peppercorns', 'boil', 0.05, '5 mins'

    add_new_ingredient name, usage, quantity, duration
    question_set.spices_redirect_menu
  end

  def thai_basil
    name, usage, quantity, duration = 'thai basil', 'boil', 2, '5 mins'

    add_new_ingredient name, usage, quantity, duration
    question_set.spices_redirect_menu
  end

  def ginger
    name, usage, quantity, duration = 'ginger', 'boil', 2, '10 mins'

    add_new_ingredient name, usage, quantity, duration
    question_set.spices_redirect_menu
  end

  def peaches
    name, usage, quantity, duration = 'peaches', 'secondary', 4, 'Until fermentation completed'

    add_new_ingredient name, usage, quantity, duration
    question_set.fruit_redirect_menu
  end

  def blackberries
    name, usage, quantity, duration = 'blackberries', 'secondary', 4, 'Until fermentation completed'

    add_new_ingredient name, usage, quantity, duration
    question_set.fruit_redirect_menu
  end

  def mango
    name, usage, quantity, duration = 'mango', 'secondary', 4, 'Until fermentation completed'

    add_new_ingredient name, usage, quantity, duration
    question_set.fruit_redirect_menu
  end

  def currants
    name, usage, quantity, duration = 'currants', 'secondary', 2, 'Until fermentation completed'

    add_new_ingredient name, usage, quantity, duration
    question_set.fruit_redirect_menu
  end

  def hibiscus
    name, usage, quantity, duration = 'hibiscus', 'secondary', 2, '5 days'

    add_new_ingredient name, usage, quantity, duration
    question_set.botanicals_redirect_menu
  end

  def lavender
    name, usage, quantity, duration = 'lavender', 'secondary', 0.5, '5 days'

    add_new_ingredient name, usage, quantity, duration
    question_set.botanicals_redirect_menu
  end

  def rose_hips
    name, usage, quantity, duration = 'rose hips', 'boil', 0.5, '5 min'

    add_new_ingredient name, usage, quantity, duration
    question_set.botanicals_redirect_menu
  end

  def corn_sugar
    name, usage, quantity = 'corn sugar', 'Peak Krausen', 1

    add_new_ingredient name, usage, quantity
    question_set.adjunct_redirect_menu
  end

  def turbinado_sugar
    name, usage, quantity = 'turbinado sugar', 'Peak Krausen', 1

    add_new_ingredient name, usage, quantity
    question_set.adjunct_redirect_menu
  end

  def rice
    name, usage, quantity = 'rice', 'Precook, mash', 1

    add_new_ingredient name, usage, quantity
    question_set.adjunct_redirect_menu
  end

  private

  def params
    @params
  end

  def record
    @record
  end

  def question_set
    @question_set
  end

end