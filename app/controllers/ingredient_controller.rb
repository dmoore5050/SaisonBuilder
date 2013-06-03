
class IngredientController

  attr_reader :params

  def initialize(ingredient_params)
    @params = ingredient_params
  end

  def create
    ingredient = Ingredient.new params[:ingredient]
    ControllerHelper.creation_success_message ingredient
  end

  def list_ingredients
    ingredients = Ingredient.all

    ingredients.each_with_index do | ingredient, i |
      render_line_item ingredient, i
    end
  end

  def render_line_item(ingredient, i)
    puts "\n" if i == 0
    list_num = (i + 1) < 10 ? " #{i + 1}" : "#{i + 1}"
    ingredient_name = "#{list_num}. #{ingredient.name.titleize}:"

    case ingredient.description
    when nil then puts "#{list_num}. #{ingredient.name.titleize}"
    else puts ingredient_name.ljust(26) + "#{ingredient.description}"
    end
  end

  def delete
    ingredient_match = Ingredient.where(name: params[:ingredient][:name]).first
    ControllerHelper.confirm_match ingredient_match
    ingr_array = RecipeIngredient.where(ingredient_id: ingredient_match.id).all
    ingr_array.each do | recipe_ingredient |
      recipe_ingredient.destroy
    end
    ingredient_match.destroy
    ControllerHelper.matching_record_destroyed_message ingredient_match
  end

end