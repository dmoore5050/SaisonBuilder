class IngredientController

  def initialize
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
    ingredients.each_with_index do |ingredient, i|
      puts "#{i+1}. #{ingredient.name}"
    end
  end

end