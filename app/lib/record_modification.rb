require_relative '../../bootstrap_ar'

class RecordModification

  attr_reader :record, :next_question

  def initialize(record = nil)
    @record = record
    @next_question = QuestionView.new record
  end

  def describe(type, name, description)
    case type
    when 'ingredient' then record = Ingredient.where(name: name).first
    when 'recipe' then record = Recipe.where(name: name).first
    end

    record.update_attributes(description: description)
  end

  def remove(name, usage, duration)
    matching_ingr = Ingredient.where(name: name)
    dropped_ingredient = RecipeIngredient.where(recipe_id: @record, ingredient_id: matching_ingr, usage: usage, duration: duration).first
    unless dropped_ingredient.nil?
      dropped_ingredient.destroy
    else
      puts "\n#{name} is not a valid ingredient name."
      puts 'Please choose from the list and follow the provided instructions.'
      next_question.remove
    end

    next_question.remove_redirect_menu
  end

  def add_new_ingredient(name, usage, quantity, duration = nil)
    ingredient = Ingredient.where(name: name).first
    @record.recipe_ingredients.create(ingredient_id: ingredient.id, usage: usage, quantity: quantity, duration: duration)
  end

  def switch_yeast(name)
    primary_yeast = record.recipe_ingredients.where(usage: 'primary').first
    primary_yeast.destroy

    usage, quantity = 'primary', 1
    add_new_ingredient name, usage, quantity
  end

  def change_primary(answer)
    name = INGREDIENT_SET[answer]

    switch_yeast name
    next_question.yeast_redirect_menu
  end

  def add_ingredient(answer, redirect)
    name, usage, quantity, duration = INGREDIENT_SET[answer]

    add_new_ingredient name, usage, quantity, duration
    next_question.send("#{redirect}")
  end

  def add_brett(answer, usage)
    name, quantity = INGREDIENT_SET[answer]

    add_new_ingredient name, usage, quantity
    next_question.yeast_redirect_menu
  end

  def add_base_grain(answer)
    base_malt = @record.recipe_ingredients.where(quantity: 6..25).first
    base_malt.update_attributes(quantity: base_malt.quantity - 3)

    add_multiple_grains answer
  end

  def add_roast(answer)
    add_multiple_grains answer
  end

  def add_multiple_grains(answer)
    args = INGREDIENT_SET[answer]

    args.each do | argument_set |
      name, usage, quantity = argument_set
      add_new_ingredient name, usage, quantity
    end
    next_question.grain_redirect_menu
  end

  def change_gravity(answer, trackback)
    base_malt = @record.recipe_ingredients.where(quantity: 6..25).first

    quantity_adjustment = base_malt.quantity + INGREDIENT_SET[answer]
    base_malt.update_attributes(quantity: quantity_adjustment)
    if answer == 'eight'
      sugar = @record.recipe_ingredients.where(ingredient_id: 38..39).first
      add_sugar_to_recipe sugar
    end

    next_question.gravity_redirect_menu
  end

  def add_sugar_to_recipe(sugar)
    if sugar.nil?
      name, usage, quantity = 'corn sugar', 'Peak krausen', 2
      add_new_ingredient name, usage, quantity
    else
      sugar.update_attributes(quantity: sugar.quantity + 1)
    end
  end

end