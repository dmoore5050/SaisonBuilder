require_relative '../test_helper'

class TestListingrecipes < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_listing_when_there_are_no_recipes
    assert Recipe.all.empty?
    expected = <<EOS

\nTo view a recipe, type 'sb view <recipe name>.
Example: $ sb view black saison
EOS
    actual = `ruby saisonbuilder list`
    assert_equal expected, actual
  end

  def test_listing_multiple_recipes
    Recipe.create(name: 'foo')
    Recipe.create(name: 'bar')
    actual = `ruby saisonbuilder list`
    expected = <<EOS

1. Foo
2. Bar
\nTo view a recipe, type 'sb view <recipe name>.
Example: $ sb view black saison
EOS
    assert_equal expected, actual
  end

end