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

end