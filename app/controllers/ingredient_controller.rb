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
    puts ' '
    ingredients.each_with_index do |ingredient, i|
      ingredient_name = "#{i+1}. #{ingredient.name}:"
      puts ingredient_name.ljust(26) + "#{ingredient.description}"
    end
  end

end