class RecipeIngredientController

  def initialize
  end

  def create
    recipe_ingredient = RecipeIngredient.new(params[:recipe_ingredient])
    case
    when recipe_ingredient.save then puts 'Success!'
    else puts "Failure: #{recipe_ingredient.errors.full_messages.join(", ")}"
    end
  end

  def delete
    matching_recipe_ingredients = RecipeIngredient.where(name: params[:recipe_ingredient][:name]).all
    matching_recipe_ingredients.each do |recipe|
      recipe.destroy
    end
  end

end