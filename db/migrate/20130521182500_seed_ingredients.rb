class SeedIngredients < ActiveRecord::Migration

  def change

    ingredient_list = [
      [ 'Pilsner', 'Pale base malt, prominent in continental examples.', 1 ],
      [ '2-row Pale Malt', 'Pale base malt, commonly used in American examples.', 1 ],
      [ 'Munich', 'Base malt, adds richness. Use to supplement wheat, pilsner, or pale malt.', 1 ],
      [ 'White Wheat Malt', 'Base malt, added to modify malt character. Doughy, mild.', 1 ],
      [ 'Caramunich 60', 'Caramel malt, adds mild caramel/toffee flavors and sweetness.', 1 ],
      [ 'Honey Malt', 'Specialty malt. Adds distinctive honey-like sweetness.', 1 ],
      [ 'Chocolate Malt', 'Kilned specialty malt. Adds nutty, chocolate flavor and color.', 1 ],
      [ 'Carafa 2 Special', 'Kilned specialty malt. Adds color, mild roasty flavors w/o harshness.', 1 ],
      [ 'Amarillo', 'New-world hop, floral, tangerine citrus character.', 2 ],
      [ 'Hallertau', 'Old-world, floral, spicy, refined.', 2 ],
      [ 'Saaz', 'Old-world, spicy, earthy.', 2 ],
      [ 'Simcoe', 'New-world, pungent, pine, grapefruit, pineapple.', 2 ],
      [ 'Sorachi', 'New-world, clean, string lemon character, bright.', 2 ],
      [ 'Styrian Goldings', 'Old-world, spicy, mildly floral, fruity.', 2 ],
      [ 'Dupont Strain', 'Ferment: ~85F, can be slow to finish. Spicy/peppery, mild fruit.', 3, 565, 3724 ],
      [ 'French Saison', 'Ferment: 65-72F. Aromatic fruit/citrus, peppery, clean.', 3, 656, 3711 ],
      [ 'American Farmhouse', 'Ferment: 65-72F. Saison/Brett blend. Mild pepper, barnyard.', 3, 670 ],
      [ 'Brett. Brux. Trois', 'Ferment: 65-72F. Mild, tart, delicate mango, pineapple.', 3, 644 ],
      [ 'Brett. Brux.', 'Ferment: 65-72F. Moderate intensity, horseblanket, bright lemon.', 3, 650, 5112 ],
      [ 'Brett. Clausenii', 'Ferment: 65-72F. Prominent pineapple/tropical fruit aromatics.', 3, 645 ],
      [ 'Brett. Lambicus', 'Ferment: 65-72F. Intense, barnyard, horseblanket, dank, musty.', 3, 653, 5526 ],
      [ 'Cardamom', 'Adds a citrusy, ginger-like flavor with elements of cinnamon or nutmeg.', 4 ],
      [ 'Citrus Zest', 'Can use an array of varieties - lemon, lime, orange, etc.', 4 ],
      [ 'White Peppercorns', 'Peppery, mild wine-like flavor.', 4 ],
      [ 'Thai Basil', 'Similar to sweet basil, but with notes of licorice.', 4 ],
      [ 'Ginger', 'Clean, warm, woody sweetness, bright.', 4 ],
      [ 'Peaches', 'Add to secondary fermentation.', 5 ],
      [ 'Blackberries', 'Add to secondary fermentation.', 5 ],
      [ 'Mango', 'Add to secondary fermentation. Tropical-fruit character, mildly tart.', 5 ],
      [ 'Currants', 'Tart, raisin-like flavor. Add to secondary fermentation.', 5 ],
      [ 'Hibiscus', 'Deep red in color, fruity flavor, notes of lemon and ripe berries.', 6 ],
      [ 'Lavender', 'Floral, spicy, notes of lemon and mint.', 6 ],
      [ 'Rose Hips', 'Floral, citrusy, sour.', 6 ],
      [ 'Corn Sugar', 'Adjunct. Adds no flavor; add to raise gravity without boosting body.', 7 ],
      [ 'Turbinado Sugar', 'Adjunct. Adds subtle molasses character.', 7 ],
      [ 'Rice', 'Adjunct. Adds crispness, lightens body. Cook before adding to mash.', 7 ]
    ]

    ingredient_list.each do |name, description, type_code, yeast_code_wl, yeast_code_wyeast|
      Ingredient.create( name: name, description: description, type_code: type_code, yeast_code_wyeast: yeast_code_wyeast, yeast_code_wl: yeast_code_wl )
    end

  end
end