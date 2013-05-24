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
      puts "#{i + 1}. #{recipe.name.titleize}"
    end
  end

  def delete
    matching_recipes = Recipe.where(name: params[:recipe][:name]).all
    matching_recipes.each do |recipe|
      recipe.destroy
    end
  end

  def view
    matching_recipe = Recipe.where(name: params[:recipe][:name]).first
    matching_id = matching_recipe.id
    ingredient_list = RecipeIngredient.where("recipe_id = #{matching_id}").all
    rendered_recipe = ''
    recipe_head = %Q(

Name:          #{matching_recipe.name.capitalize}
Batch size:    5 gallons
Mash:          90 mins @ 149F
Boil length:   #{matching_recipe.boil_length} mins

)
    rendered_recipe << recipe_head

  ingredient_types = %w(grain adjunct hop spice botanical yeast)
  ingredient_types.each do | type |
    rendered_recipe << render_ingredient_bill(type, ingredient_list)
  end

    recipe_foot = %Q(
Primary Fermentation Temp:  #{matching_recipe.primary_fermentation_temp}
)
    rendered_recipe << recipe_foot
    puts rendered_recipe
  end

  def render_ingredient_bill(match_code, ingredient_list)
    ingredient_bill = ''

    case match_code
    when 'hop' || 'spice' || 'botanicals' then measure = 'oz'
    when 'yeast' then measure = 'package'
    else measure = 'lbs'
    end

    ingredient_list.each do | ingredient |
      ingredient_record = Ingredient.where("id = #{ingredient.ingredient_id}").first
      # puts match_code + ' ' + ingredient_record.type_code
      if ingredient_record.type_code == match_code
        line_item = "#{ingredient.quantity} #{measure} #{ingredient_record.name.titleize}"
        if !ingredient.duration.nil?
          line_item << ", @ #{ingredient.duration} "
        elsif !ingredient.usage.nil?
          line_item << ", #{ingredient.usage.capitalize} "
        elsif !ingredient_record.yeast_code_wl.nil?
          line_item << "White Labs WLP#{ingredient_record.yeast_code_wl}"
        elsif !ingredient_record.yeast_code_wyeast.nil?
          line_item << ", Wyeast #{ingredient_record.yeast_code_wyeast}"
        end
        line_item << "\n"
        ingredient_bill << line_item
      end
    end
    ingredient_bill
  end

  private

  def params
    @params
  end

end