INGREDIENT_PRINT_ORDER = %w(grain adjunct hop spice fruit botanical yeast)

class RecipeView

  attr_reader :matching_recipe

  def initialize(matching_recipe)
    @matching_recipe = matching_recipe
  end

  def render_recipe
    ingredient_list = RecipeIngredient.where(recipe_id: matching_recipe.id).all

    rendered_recipe = recipe_head matching_recipe
    INGREDIENT_PRINT_ORDER.each do | type |
      rendered_recipe += render_ingredient_bill(type, ingredient_list)
    end
    rendered_recipe += recipe_foot matching_recipe

    puts rendered_recipe
  end

  def recipe_head(matching_recipe)
    head = %Q(
Name:          #{matching_recipe.name.titleize}
Batch size:    5 gallons
Mash:          90 mins @ 149F
Boil length:   #{matching_recipe.boil_length} mins

)
  end

  def recipe_foot(matching_recipe)
    foot = %Q(
Primary Fermentation Temp:  #{matching_recipe.primary_fermentation_temp}
)
  end

  def render_ingredient_bill(type, ingredient_list)
    ingredient_bill = ''

    ingredient_list.each do | ingredient |
      ingr_record = Ingredient.where("id = #{ingredient.ingredient_id}").first
      if ingr_record.type_code == type
        ingredient_bill += build_recipe_line_item type, ingredient, ingr_record
      end
    end
    ingredient_bill
  end

  def build_recipe_line_item(type, ingredient, ingr_record)
    measure = quantity_unit type
    usage_indicator = ingredient.usage == 'boil' ? '@ ' : nil
    line_item = "#{ingredient.quantity} #{measure} #{ingr_record.name.titleize}".ljust(28)
    line_item += "Add during: #{ingredient.usage.capitalize}" unless ingredient.usage.nil?
    line_item += ", #{usage_indicator}#{ingredient.duration}" unless ingredient.duration.nil?
    line_item += ". Mfg. code(s): White Labs WLP#{ingr_record.yeast_code_wl}" unless ingr_record.yeast_code_wl.nil?
    line_item += ", Wyeast #{ingr_record.yeast_code_wyeast}" unless ingr_record.yeast_code_wyeast.nil?
    line_item += "\n"
  end

  def quantity_unit(type)
    case type
    when 'spice' then 'oz'
    when 'hop' then 'oz'
    when 'botanical' then 'oz'
    when 'yeast' then 'pkg'
    else 'lbs'
    end
  end
end