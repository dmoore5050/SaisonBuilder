require_relative '../../bootstrap_ar'

class RecipeController

  attr_reader :params, :matching_recipe

  INGREDIENT_PRINT_ORDER = %w(grain adjunct hop spice fruit botanical yeast)

  def initialize(params)
      @params = params
      set_matching_recipe
  end

  def set_matching_recipe
    check_if_name_is_entered
    @matching_recipe = Recipe.where(name: params[:recipe][:name]).first
  end

  def check_if_name_is_entered
    if params[:recipe][:name].nil?
      puts "\nYou did not specify a recipe name."
      puts 'To view a list of possible recipes, type sb list'
      exit
    end
  end

  def check_if_name_matches_a_recipe(matching_recipe)
    if matching_recipe.nil?
      puts "\n#{params[:recipe][:name].titleize} is not a valid recipe name."
      puts 'To view a list of possible recipes, type sb list'
      exit
    end
  end

  def create
    recipe = Recipe.new params[:recipe]
    case
    when recipe.save then puts 'Success!'
    else puts "Failure: #{recipe.errors.full_messages.join(", ")}"
    end
  end

  def list_recipes
    recipes = Recipe.all
    puts "\n"
    recipes.each_with_index do |recipe, i|
      puts build_list_item recipe, i
    end
    puts "\nTo view a recipe, type: sb view <recipe name>."
    puts 'Example: sb view black saison'
  end

  def build_list_item(recipe, i)
    formatted_name = recipe.name.titleize + ':'
    num = i < 9 ? " #{i + 1}" : i + 1
    case recipe.description
    when nil then "#{num}. #{recipe.name.titleize}"
    else "#{num}. #{formatted_name.ljust(21)}#{recipe.description.capitalize}"
    end
  end

  def delete
    check_if_name_matches_a_recipe matching_recipe
    ingr_array = RecipeIngredient.where(recipe_id: matching_recipe.id).all
    ingr_array.each do | recipe_ingredient |
      recipe_ingredient.destroy
    end
    matching_recipe.destroy
    generate_recipe_destroyed_message matching_recipe
  end

  def generate_recipe_destroyed_message(matching_recipe)
    case
    when matching_recipe.destroyed?
      puts "\n#{params[:recipe][:name].titleize} has been deleted."
    else puts "Failure: #{recipe.errors.full_messages.join(", ")}"
    end
  end

  def view
    check_if_name_matches_a_recipe @matching_recipe
    ingredient_list = RecipeIngredient.where(recipe_id: matching_recipe.id).all

    rendered_recipe = recipe_head matching_recipe
    INGREDIENT_PRINT_ORDER.each do | type |
      rendered_recipe += render_ingredient_bill(type, ingredient_list)
    end
    rendered_recipe += recipe_foot matching_recipe

    puts rendered_recipe
  end

  def recipe_head(matching_recipe)
    head = %Q(
Name:          #{matching_recipe.name.titleize}
Batch size:    5 gallons
Mash:          90 mins @ 149F
Boil length:   #{matching_recipe.boil_length} mins

)
  end

  def recipe_foot(matching_recipe)
    foot = %Q(
Primary Fermentation Temp:  #{matching_recipe.primary_fermentation_temp}
)
  end

  def render_ingredient_bill(match_code, ingredient_list)
    ingredient_bill = ''

    ingredient_list.each do | ingredient |
      ingr_record = Ingredient.where("id = #{ingredient.ingredient_id}").first
      if ingr_record.type_code == match_code
        ingredient_bill += build_recipe_line_item match_code, ingredient, ingr_record
      end
    end
    ingredient_bill
  end

  def build_recipe_line_item(match_code, ingredient, ingr_record)
    measure = quantity_unit match_code
    usage_indicator = ingredient.usage == 'boil' ? '@ ' : nil
    line_item = "#{ingredient.quantity} #{measure} #{ingr_record.name.titleize}".ljust(28)
    line_item += "Add during: #{ingredient.usage.capitalize}" unless ingredient.usage.nil?
    line_item += ", #{usage_indicator}#{ingredient.duration}" unless ingredient.duration.nil?
    line_item += ". Mfg. code(s): White Labs WLP#{ingr_record.yeast_code_wl}" unless ingr_record.yeast_code_wl.nil?
    line_item += ", Wyeast #{ingr_record.yeast_code_wyeast}" unless ingr_record.yeast_code_wyeast.nil?
    line_item += "\n"
  end

  def quantity_unit(match_code)
    case match_code
    when 'hop' || 'spice' || 'botanicals' then 'oz'
    when 'yeast' then 'pkg'
    else 'lbs'
    end
  end

end