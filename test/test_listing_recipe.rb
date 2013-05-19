require 'test_helper'

class TestListingrecipes < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_listing_when_there_are_no_recipes
    assert Recipe.all.empty?
    actual = `ruby saisonbuilder list`
    assert_equal "", actual
  end

  def test_listing_multiple_recipes
    Recipe.create(name: 'foo')
    Recipe.create(name: 'bar')
    actual = `ruby saisonbuilder list`
    expected = <<EOS
1. foo
2. bar
EOS
    assert_equal expected, actual
  end

end