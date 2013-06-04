require_relative '../../bootstrap_ar'

class RecordModification

  attr_reader :record, :next_question

  def initialize(record = nil)
    @record = record
    @next_question = QuestionView.new record
  end

  def describe(type, name, description)
    case type
    when 'ingredient' then record_match = Ingredient.where(name: name)
    when 'recipe' then record_match = Recipe.where(name: name)
    end

    record_match.update_attributes(description: description)
  end

  def remove(name, usage, duration)
    matching_ingr = Ingredient.where(name: name)
    dropped_ingredient = RecipeIngredient.where(recipe_id: @record, ingredient_id: matching_ingr, usage: usage, duration: duration).first
    dropped_ingredient.destroy

    next_question.remove_redirect_menu
  end

  def add_new_ingredient(name, usage, quantity, duration = nil)
    ingr = Ingredient.where(name: name).first
    @record.recipe_ingredients.create(ingredient_id: ingr, usage: usage, quantity: quantity, duration: duration)
  end

  def switch_yeast(name)
    primary_yeast = record.recipe_ingredients.where(usage: 'primary').first
    usage, quantity =  primary_yeast.usage, primary_yeast.quantity
    primary_yeast.destroy

    add_new_ingredient name, usage, quantity
  end

  def change_primary(answer, trackback)
    name = INGREDIENT_SET[answer]

    switch_yeast name
    next_question.yeast_redirect_menu
  end

  def add_brett(answer, trackback, yeast_usage)
    name, usage, quantity = INGREDIENT_SET[answer], yeast_usage, 1

    add_new_ingredient name, usage, quantity
    next_question.yeast_redirect_menu
  end

  def add_sweetness(answer, trackback)
    name, usage, quantity = INGREDIENT_SET[answer], nil, 0.5

    add_new_ingredient name, usage, quantity
    next_question.grain_redirect_menu
  end

  def add_base_grain(answer, trackback)
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first
    base_malt.update_attributes(quantity: base_malt.quantity - 3)

    add_multiple_grains answer, trackback
  end

  def add_roast(answer, trackback)
    add_multiple_grains answer, trackback
  end

  def add_multiple_grains(answer, trackback)
    args = INGREDIENT_SET[answer]

    args.each do | argument_set |
      name, usage, quantity = argument_set
      add_new_ingredient name, usage, quantity
    end
    next_question.grain_redirect_menu
  end

  def change_gravity(answer, trackback)
    base_malt = RecipeIngredient.where(recipe_id: @record, quantity: 6..25).first

    case answer
    when 'eight'
     quantity_adjustment = base_malt.quantity + 1.5
     sugar = RecipeIngredient.where(recipe_id: @record, ingredient_id: 38..39).first
     add_sugar_to_recipe sugar
    when 'seven' then quantity_adjustment = base_malt.quantity + 1.5
    when 'five'  then quantity_adjustment = base_malt.quantity - 1.5
    when 'four'  then quantity_adjustment = base_malt.quantity - 3
    else repeat_question answer, trackback
    end

    base_malt.update_attributes(quantity: quantity_adjustment)

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

  def add_late_ingredient(answer, trackback, redirect)
    name, usage, quantity, duration = INGREDIENT_SET[answer]

    add_new_ingredient name, usage, quantity, duration
    next_question.send("#{redirect}")
  end

end