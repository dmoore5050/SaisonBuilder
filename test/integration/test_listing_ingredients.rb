require_relative '../test_helper'

class TestListingIngredients < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_ingredient_list_is_populated
    assert !Ingredient.all.empty?
    expected = <<EOS

 1. Pilsner:              Pale base malt, prominent in continental examples.
 2. Pale Malt:            Pale base malt, commonly used in American examples.
 3. Munich:               Base malt, adds richness. Use to supplement wheat, rye, pilsner, or pale malt.
 4. White Wheat Malt:     Base malt, added to modify malt character. Doughy, mild.
 5. Amarillo:             New-world hop, floral, tangerine citrus character.
 6. Hallertau:            Old-world, floral, spicy, refined.
 7. Saaz:                 Old-world, spicy, earthy.
 8. Simcoe:               New-world, pungent, pine, grapefruit, pineapple.
 9. Styrian Goldings:     Old-world, spicy, mildly floral, fruity.
10. Motueka:              New-world, lemon-lime, bright citrus.
11. Dupont Strain:        Ferment: ~85F, can be slow to finish. Spicy/peppery, mild fruit.
12. French Saison:        Ferment: 65-72F. Aromatic fruit/citrus, peppery, clean.
13. Turbinado Sugar:      Adjunct. Adds subtle molasses character.
14. Corn Sugar:           Adjunct. Adds no flavor; add to raise gravity without boosting body.
EOS
    actual = `ruby sb ingredients`
    assert_equal expected, actual
  end

  def test_listing_additional_ingredients
    Ingredient.create(name: 'foo')
    Ingredient.create(name: 'bar')
    actual = `ruby sb ingredients`
    expected = <<EOS

 1. Pilsner:              Pale base malt, prominent in continental examples.
 2. Pale Malt:            Pale base malt, commonly used in American examples.
 3. Munich:               Base malt, adds richness. Use to supplement wheat, rye, pilsner, or pale malt.
 4. White Wheat Malt:     Base malt, added to modify malt character. Doughy, mild.
 5. Amarillo:             New-world hop, floral, tangerine citrus character.
 6. Hallertau:            Old-world, floral, spicy, refined.
 7. Saaz:                 Old-world, spicy, earthy.
 8. Simcoe:               New-world, pungent, pine, grapefruit, pineapple.
 9. Styrian Goldings:     Old-world, spicy, mildly floral, fruity.
10. Motueka:              New-world, lemon-lime, bright citrus.
11. Dupont Strain:        Ferment: ~85F, can be slow to finish. Spicy/peppery, mild fruit.
12. French Saison:        Ferment: 65-72F. Aromatic fruit/citrus, peppery, clean.
13. Turbinado Sugar:      Adjunct. Adds subtle molasses character.
14. Corn Sugar:           Adjunct. Adds no flavor; add to raise gravity without boosting body.
15. Foo
16. Bar
EOS
    assert_equal expected, actual
  end
end