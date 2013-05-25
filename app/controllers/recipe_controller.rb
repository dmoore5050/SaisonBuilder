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
    puts "\n"
    recipes.each_with_index do |recipe, i|
      puts "#{i + 1}. #{recipe.name.titleize}"
    end
    puts "\nTo view a recipe, type 'sb view <recipe name>."
    puts "Example: $ sb view black saison"
  end

  def delete
    matching_recipes = Recipe.where(name: params[:recipe][:name]).all
    matching_recipes.each do | recipe |
      ingr_array = RecipeIngredient.where(recipe_id: recipe.id).all
      ingr_array.each do | recipe_ingredient |
        recipe_ingredient.destroy
      end
      recipe.destroy
    end
  end

  def view
    matching_recipe = Recipe.where(name: params[:recipe][:name]).first
    if matching_recipe.nil?
      puts "\nThat is not a valid recipe name."
      puts 'To view a list of possible recipes, type sb list'
      return
    end
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

  ingredient_print_order = %w(grain adjunct hop spice botanical yeast)
  ingredient_print_order.each do | type |
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

    ingredient_list.each do | ingredient |
      ingr_record = Ingredient.where("id = #{ingredient.ingredient_id}").first
      if ingr_record.type_code == match_code
        ingredient_bill << build_line_item(match_code, ingredient, ingr_record)
      end
    end
    ingredient_bill
  end

  def build_line_item(match_code, ingredient, ingr_record)
    measure = quantity_unit match_code

    line_item = "#{ingredient.quantity} #{measure} #{ingr_record.name.titleize}".ljust(28)
    line_item << "Add during: #{ingredient.usage.capitalize}" unless ingredient.usage.nil?
    line_item << ", @ #{ingredient.duration}" unless ingredient.duration.nil?
    line_item << ". Mfg. code(s): White Labs WLP#{ingr_record.yeast_code_wl}" unless ingr_record.yeast_code_wl.nil?
    line_item << ", Wyeast #{ingr_record.yeast_code_wyeast}" unless ingr_record.yeast_code_wyeast.nil?
    line_item << "\n"
  end

  def quantity_unit(match_code)
    case match_code
    when 'hop' || 'spice' || 'botanicals' then 'oz'
    when 'yeast' then 'pkg'
    else 'lbs'
    end
  end

  private

  def params
    @params
  end

end