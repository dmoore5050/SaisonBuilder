
class IngredientController

  def initialize(params)
    @params = params
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
    puts "\n"
    ingredients.each_with_index do | ingredient, i |
      list_num = (i + 1) < 10 ? " #{i + 1}" : "#{i + 1}"
      ingredient_name = "#{list_num}. #{ingredient.name.titleize}:"
      if !ingredient.description.nil?
        puts ingredient_name.ljust(26) + "#{ingredient.description}"
      else
        puts "#{list_num}. #{ingredient.name.titleize}"
      end
    end
  end

  def delete
    check_if_name_is_entered
    matching_ingredient = Ingredient.where(name: params[:ingredient][:name]).first
    check_if_name_matches_ingredient matching_ingredient
    ingr_array = RecipeIngredient.where(ingredient_id: matching_ingredient.id).all
    ingr_array.each do | recipe_ingredient |
      recipe_ingredient.destroy
    end
    matching_ingredient.destroy
    generate_ingredient_destroyed_message
  end

  def check_if_name_is_entered
    if params[:ingredient][:name].nil?
      puts "\nYou did not specify an ingredient name."
      puts 'To view a list of possible ingredients, type sb ingredients'
      exit
    end
  end

  def check_if_name_matches_recipe(matching_ingredient)
    if matching_ingredent.nil?
      puts "\n#{params[:recipe][:name].titleize} is not a valid ingredient name."
      puts 'To view a list of possible ingredients, type ingredient list'
      exit
    end
  end

  def generate_ingredient_destroyed_message
    case
    when matching_ingredient.destroyed?
      puts "\n#{params[:ingredient][:name].titleize} has been deleted."
    else puts "Failure: #{ingredient.errors.full_messages.join(", ")}"
    end
  end

  private

  def params
    @params
  end

end