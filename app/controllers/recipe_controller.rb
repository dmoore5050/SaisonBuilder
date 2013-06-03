require_relative '../../bootstrap_ar'

class RecipeController

  attr_reader :params, :matching_recipe

  def initialize(params)
      @params = params
      @matching_recipe = Recipe.where(name: params[:recipe][:name]).first
  end

  def create
    recipe = Recipe.new params[:recipe]
    Helper.creation_success_message recipe
  end

  def list_recipes
    recipes = Recipe.all
    puts "\n"
    recipes.each_with_index do | recipe, i |
      puts build_list_item recipe, i
    end
    puts "\nTo view a recipe, type: ruby sb view <recipe name>."
    puts 'Example: ruby sb view black saison'
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
    Helper.matching_record_destroyed_message matching_recipe
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
    recipe_view = RecipeView.new (@matching_recipe)
    recipe_view.render_recipe
  end

  def check_if_name_matches_a_recipe(matching_recipe)
    if matching_recipe.nil?
      puts "\n#{params[:recipe][:name].titleize} is not a valid recipe name."
      puts 'To view a list of possible recipes, type: ruby sb list'
      exit
    end
  end

end