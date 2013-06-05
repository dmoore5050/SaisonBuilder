require_relative '../test_helper'

class TestRecordModification < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_saves_record_on_record_modification_creation
    record = Recipe.create(name: 'test_record')
    modification = RecordModification.new record

    assert_equal record, modification.record
  end

  def test_describe_adds_description_to_ingredient
    ingredient = Ingredient.create(name: 'test')
    mod = RecordModification.new

    type, name, description = 'ingredient', 'test', 'A description'
    mod.describe type, name, description

    new_ingredient = Ingredient.where(name: 'test').first
    expected = 'A description'
    actual = new_ingredient.description

    assert_equal expected, actual

  end

  def test_describe_adds_description_to_recipe
    record = Recipe.create(name: 'test')
    mod = RecordModification.new

    type, name, description = 'recipe', 'test', 'A description'
    mod.describe type, name, description

    described_record = Recipe.where(name: 'test').first
    expected = 'A description'
    actual = described_record.description

    assert_equal expected, actual
  end

  def test_add_new_ingredient_adds_ingredient
    @record = Recipe.create(name: 'test')
    mod = RecordModification.new @record

    assert_equal @record.recipe_ingredients.count, 0

    ingredient_name, usage, quantity, duration = 'saaz', 'boil', 1, '30 min'
    mod.add_new_ingredient ingredient_name, usage, quantity, duration

    assert_equal @record.recipe_ingredients.count, 1
  end

  def test_add_new_ingredient_adds_correct_ingredient
    @record = Recipe.create(name: 'test')
    mod = RecordModification.new @record

    ingredient_name, usage, quantity, duration = 'saaz', 'boil', 1, '30 min'
    mod.add_new_ingredient ingredient_name, usage, quantity, duration

    added_ingredient = @record.recipe_ingredients.last
    ingredient = Ingredient.where(name: 'saaz').first

    assert_equal added_ingredient.ingredient_id, ingredient.id
  end

  def test_add_new_ingredient_sets_correct_parameters
    @record = Recipe.create(name: 'test')
    mod = RecordModification.new @record

    ingredient_name, usage, quantity, duration = 'saaz', 'boil', 1, '30 min'
    mod.add_new_ingredient ingredient_name, usage, quantity, duration

    added_ingredient = @record.recipe_ingredients.last
    actual_usage    = added_ingredient.usage
    actual_duration = added_ingredient.duration
    actual_quantity = added_ingredient.quantity

    assert_equal usage,    actual_usage
    assert_equal duration, actual_duration
    assert_equal quantity, actual_quantity
  end

  def test_switch_yeast_deletes_former_primary_yeast
    record = Recipe.where(name: 'classic').first
    ingredient = Ingredient.where(name: 'dupont strain').first

    mod = RecordModification.new record

    mod.switch_yeast 'french saison'
    recipe_yeast = record.recipe_ingredients.where(ingredient_id: ingredient.id).all

    expected = 0
    actual = recipe_yeast.count

    assert_equal expected, actual

  end

  def test_switch_yeast_adds_new_primary_yeast
    record = Recipe.where(name: 'classic').first
    ingredient = Ingredient.where(name: 'french saison').first

    mod = RecordModification.new record

    mod.switch_yeast 'french saison'
    recipe_yeast = record.recipe_ingredients.where(ingredient_id: ingredient.id).all

    expected = 1
    actual = recipe_yeast.count

    assert_equal expected, actual
  end

  def test_alter_gravity_ingredients_changes_base_malt_quantity
    record = Recipe.where(name: 'classic').first
    mod = RecordModification.new record

    base_malt = record.recipe_ingredients.where(quantity: 6..25).first

    expected = 9
    actual = base_malt.quantity
    assert_equal expected, actual

    mod.alter_gravity_ingredients 'seven'

    revised_base_malt = record.recipe_ingredients.where(quantity: 6..25).first

    revised_expected = 10.5
    revised_actual = revised_base_malt.quantity
    assert_equal revised_expected, revised_actual
  end

  def test_alter_gravity_ingredients_changes_sugar_quantity
    record = Recipe.where(name: 'classic').first
    mod = RecordModification.new record
    base_sugar = Ingredient.where(name: 'corn sugar').first

    sugar = record.recipe_ingredients.where(ingredient_id: base_sugar.id).first
    expected = 1
    actual = sugar.quantity
    assert_equal expected, actual

    mod.alter_gravity_ingredients 'eight'

    revised_sugar = record.recipe_ingredients.where(ingredient_id: base_sugar.id).first

    revised_expected = 2
    revised_actual = revised_sugar.quantity
    assert_equal revised_expected, revised_actual
  end

  def test_add_sugar_to_recipe_creates_new_sugar
    record = Recipe.where(name: 'new world').first
    mod = RecordModification.new record
    base_sugar = Ingredient.where(name: 'corn sugar').first

    sugar = record.recipe_ingredients.where(ingredient_id: base_sugar.id).first

    assert_equal sugar, nil

    mod.add_sugar_to_recipe sugar

    revised_sugar = record.recipe_ingredients.where(ingredient_id: base_sugar.id).first

    refute_equal revised_sugar, nil

    expected = 1
    actual = revised_sugar.quantity

    assert_equal expected, actual
  end

end