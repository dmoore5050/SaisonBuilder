class RecipeController

  def initialize(params)
    @params = params
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
    recipes.each_with_index do |recipe, i|
      puts "#{i + 1}. #{recipe.name}"
    end
  end

  def delete
    matching_recipes = Recipe.where(name: params[:recipe][:name]).all
    matching_recipes.each do |recipe|
      recipe.destroy
    end
  end

  private

  def params
    @params
  end

end