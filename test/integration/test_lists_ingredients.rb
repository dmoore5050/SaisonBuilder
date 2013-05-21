require_relative '../test_helper'

class TestPrintTechniquesList < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_prints_techniques_list
    actual = `ruby saisonbuilder ingredients`
    expected = <<EOS
1. Pilsner:               Pale base malt, prominent in continental examples.
2. 2-row Pale Malt:       Pale base malt, commonly used in American examples.
3. Munich:                Base malt, adds richness. Use to supplement wheat, pilsner, or pale malt.
4. White Wheat Malt:      Base malt, added to modify malt character. Doughy, mild.
5. Caramunich 60:         Caramel malt, adds mild caramel/toffee flavors and sweetness.
6. Honey Malt:            Specialty malt. Adds distinctive honey-like sweetness.
7. Chocolate Malt:        Kilned specialty malt. Adds nutty, chocolate flavor and color.
8. Carafa 2 Special:      Kilned specialty malt. Adds color, mild roasty flavors w/o harshness.
9. Amarillo:              New-world hop, floral, tangerine citrus character.
10. Hallertau:            Old-world, floral, spicy, refined.
11. Saaz:                 Old-world, spicy, earthy.
12. Simcoe:               New-world, pungent, pine, grapefruit, pineapple.
13. Sorachi:              New-world, clean, string lemon character, bright.
14. Styrian Goldings:     Old-world, spicy, mildly floral, fruity.
15. Dupont Strain:        Ferment: ~85F, can be slow to finish. Spicy/peppery, mild fruit.
16. French Saison:        Ferment: 65-72F. Aromatic fruit/citrus, peppery, clean.
17. American Farmhouse:   Ferment: 65-72F. Saison/Brett blend. Mild pepper, barnyard.
18. Brett. Brux. Trois:   Ferment: 65-72F. Mild, tart, delicate mango, pineapple.
19. Brett. Brux.:         Ferment: 65-72F. Moderate intensity, horseblanket, bright lemon.
20. Brett. Clausenii:     Ferment: 65-72F. Prominent pineapple/tropical fruit aromatics.
21. Brett. Lambicus:      Ferment: 65-72F. Intense, barnyard, horseblanket, dank, musty.
22. Cardamom:             Adds a citrusy, ginger-like flavor with elements of cinnamon or nutmeg.
23. Citrus Zest:          Can use an array of varieties - lemon, lime, orange, etc.
24. White Peppercorns:    Peppery, mild wine-like flavor.
25. Thai Basil:           Similar to sweet basil, but with notes of licorice.
26. Ginger:               Clean, warm, woody sweetness, bright.
27. Peaches:              Add to secondary fermentation.
28. Blackberries:         Add to secondary fermentation.
29. Mango:                Add to secondary fermentation. Tropical-fruit character, mildly tart.
30. Currants:             Tart, raisin-like flavor. Add to secondary fermentation.
31. Hibiscus:             Deep red in color, fruity flavor, notes of lemon and ripe berries.
32. Lavender:             Floral, spicy, notes of lemon and mint.
33. Rose Hips:            Floral, citrusy, sour.
34. Corn Sugar:           Adjunct. Adds no flavor; add to raise gravity without boosting body.
35. Turbinado Sugar:      Adjunct. Adds subtle molasses character.
36. Rice:                 Adjunct. Adds crispness, lightens body. Cook before adding to mash.
EOS

    assert_equal expected, actual
  end
end