class RecipeIngredientController

  def initialize
  end

  def create
    recipe_ingredient = RecipeIngredient.new(params[:recipe_ingredient])
    Helper.creation_success_message recipe_ingredient
  end

end