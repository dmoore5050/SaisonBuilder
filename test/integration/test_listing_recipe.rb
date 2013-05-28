require_relative '../test_helper'

class TestListingrecipes < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_list_is_populated
    assert !Recipe.all.empty?
    expected = <<EOS

1. Classic:             Dry, rustic, yeast-centric, light pear, unadorned.
2. New World:           Dry, bright, citrus, fruit, peppery.

To view a recipe, type: sb view <recipe name>.
Example: sb view black saison
EOS
    actual = `ruby saisonbuilder list`
    assert_equal expected, actual
  end

  def test_listing_multiple_recipes
    Recipe.create(name: 'foo')
    Recipe.create(name: 'bar')
    actual = `ruby saisonbuilder list`
    expected = <<EOS

1. Classic:             Dry, rustic, yeast-centric, light pear, unadorned.
2. New World:           Dry, bright, citrus, fruit, peppery.
3. Foo
4. Bar

To view a recipe, type: sb view <recipe name>.
Example: sb view black saison
EOS
    assert_equal expected, actual
  end

end