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
      ingredient_name = "#{i + 1}. #{ingredient.name.capitalize}:"
      puts ingredient_name.capitalize.ljust(26) + "#{ingredient.description}"
    end
  end

  def delete
    matching_ingredients = Ingredient.where(name: params[:ingredient][:name]).all
    matching_ingredients.each do |ingredient|
      ingredient.destroy
    end
  end

  def dupont
    # change primary to dupont
  end

  def french
    # change primary to french
  end

  def american
    # change primary to american
  end

  def blend_brett_c
    # add brett as addl primary
  end

  def blend_brett_b
    # add brett as addl primary
  end

  def blend_brett_l
    # add brett as addl primary
  end

  def only_brett_c
    # replace primary with brett
  end

  def only_brett_b
    # replace primary with brett
  end

  def only_brett_b_trois
    # replace primary with brett
  end

  def only_brett_l
    # replace primary with brett
  end

  def secondary_brett_c
    # add brett as secondary
  end

  def secondary_brett_b
    # add brett as secondary
  end

  def secondary_brett_l
    # add brett as secondary
  end

  def caramel
    # add 0.5 lb caramunich 60
  end

  def honey
    # add 0.5 lb honey malt
  end

  def eight
    # add 1.5 lb base malt, 1 lb sugar
  end

  def seven
    # add 1.5 lb base malt
  end

  def five
    # subtract 1.5 lb base malt
  end

  def four
    # subtract 3 lbs base malt
  end

  def bitterness
    # add 0.5oz bittering hops 60mins
  end

  def floral_spicy
    # add 1oz hallertau, 15 mins
  end

  def piney_citrus
    # add 1oz amarillo, 15mins
  end

  def floral
    # add 1oz hallertau, dryhop 5 days
  end

  def spicy
    # add 1oz saaz, dryhop 5 days
  end

  def citrus
    # add 1oz amarillo, dryhop 5 days
  end

  def coriander
    # 1oz @ 10 mins boil
  end

  def citrus_zest
    # 1/2 to 1oz, @ 10mins boil
  end

  def white_peppercorns
    # 1/2 tsp @ 5mins boil
  end

  def thai_basil
    # 2oz fresh basil @ 5 mins boil
  end

  def ginger
    # 2 oz fresh grated ginger @ 10mins boil
  end

  def peaches
    # rack beer onto fruit in secondary
  end

  def blackberries
    # rack beer onto fruit in secondary
  end

  def mango
    # rack beer onto fruit in secondary
  end

  def currants
    # rack beer onto fruit in secondary
  end

  def hibiscus
    # 2oz in secondary
  end

  def lavender
    # 1/2oz in secondary
  end

  def rose_hips
    # 1/2oz @ 5mins boil
  end

  def corn_sugar
    # add sugar to beer at peak krausen
  end

  def turbinado_sugar
    # add sugar to beer at peak krausen
  end

  def rice
    # precook rice according to instructions, add to mash
  end

end