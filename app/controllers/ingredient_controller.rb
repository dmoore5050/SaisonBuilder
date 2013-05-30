
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
    matching_ingredients = Ingredient.where(name: params[:ingredient][:name]).all
    matching_ingredients.each do |ingredient|
      ingredient.destroy
    end
  end

  private

  def params
    @params
  end

end