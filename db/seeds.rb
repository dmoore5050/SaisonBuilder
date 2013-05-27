require_relative '../bootstrap_ar'
connect_to 'development'

ingredient_list = [
  ['pilsner', 'Pale base malt, prominent in continental examples.', 'grain'],
  ['pale malt', 'Pale base malt, commonly used in American examples.', 'grain'],
  ['munich', 'Base malt, adds richness. Use to supplement wheat, rye, pilsner, or pale malt.', 'grain'],
  ['rye malt', 'Base malt, adds earthy, rtic malt character.', 'grain'],
  ['wheat malt', 'Base malt, added to modify malt character. Doughy, mild.', 'grain'],
  ['caramunich', 'Caramel malt, adds mild caramel/toffee flavors and sweetness.', 'grain'],
  ['honey malt', 'Specialty malt. Adds distinctive honey-like sweetness.', 'grain'],
  ['chocolate malt', 'Kilned specialty malt. Adds nutty, chocolate flavor and color.', 'grain'],
  ['carafa 2 special', 'Kilned specialty malt. Adds color, mild roasty flavors w/o harshness.', 'grain'],
  ['rice hulls', 'Imparts no flavor or sugar. Used to prevent stuck sparges when using wheat or rye.', 'grain'],
  ['flaked oats', 'Contributes silky mouthfeel, and mildy nutty flavor if toasted.', 'grain'],
  ['amarillo', 'New-world hop, floral, tangerine citrus character.', 'hop'],
  ['hallertau', 'Old-world, floral, spicy, refined.', 'hop'],
  ['saaz', 'Old-world, spicy, earthy.', 'hop'],
  ['simcoe', 'New-world, pungent, pine, grapefruit, pineapple.', 'hop'],
  ['sorachi', 'New-world, clean, string lemon character, bright.', 'hop'],
  ['styrian goldings', 'Old-world, spicy, mildly floral, fruity.', 'hop'],
  ['motueka', 'New-world, lemon-lime, bright citrus.', 'hop'],
  ['dupont strain', 'Ferment: ~85F, can be slow to finish. Spicy/peppery, mild fruit.', 'yeast', 565, 3724],
  ['french saison', 'Ferment: 65-72F. Aromatic fruit/citrus, peppery, clean.', 'yeast', 656, 3711],
  ['american farmhouse', 'Ferment: 65-72F. Saison/Brett blend. Mild pepper, barnyard.', 'yeast', 670],
  ['brett. brux. trois', 'Ferment: 65-72F. Mild, tart, delicate mango, pineapple.', 'yeast', 644],
  ['brett. brux.', 'Ferment: 65-72F. Moderate intensity, horseblanket, bright lemon.', 'yeast', 650, 5112],
  ['brett. clausenii', 'Ferment: 65-72F. Prominent pineapple/tropical fruit aromatics.', 'yeast', 645],
  ['brett. lambicus', 'Ferment: 65-72F. Intense, barnyard, horseblanket, dank, musty.', 'yeast', 653, 5526],
  ['cardamom', 'Adds a citrusy, ginger-like flavor with elements of cinnamon or nutmeg.', 'spice'],
  ['citrus zest', 'Can use an array of varieties - lemon, lime, orange, etc.', 'spice'],
  ['white peppercorns', 'Peppery, mild wine-like flavor.', 'spice'],
  ['thai basil', 'Similar to sweet basil, but with notes of licorice.', 'spice'],
  ['ginger', 'Clean, warm, woody sweetness, bright.', 'spice'],
  ['peaches', 'Add to secondary fermentation.', 'fruit'],
  ['blackberries', 'Add to secondary fermentation.', 'fruit'],
  ['mango', 'Add to secondary fermentation. Tropical-fruit character, mildly tart.', 'fruit'],
  ['currants', 'Tart, raisin-like flavor. Add to secondary fermentation.', 'fruit'],
  ['hibiscus', 'Deep red in color, fruity flavor, notes of lemon and ripe berries.', 'botanical'],
  ['lavender', 'Floral, spicy, notes of lemon and mint.', 'botanical'],
  ['rose hips', 'Floral, citrusy, sour.', 'botanical'],
  ['corn sugar', 'Adjunct. Adds no flavor; add to raise gravity without boosting body.', 'adjunct'],
  ['turbinado sugar', 'Adjunct. Adds subtle molasses character.', 'adjunct'],
  ['rice', 'adjunct. Adds crispness, lightens body. Cook before adding to mash.', 'adjunct']
]

ingredient_list.each do | name, description, type_code, yeast_code_wl, yeast_code_wyeast|
  Ingredient.create(name: name, description: description, type_code: type_code, yeast_code_wyeast: yeast_code_wyeast, yeast_code_wl: yeast_code_wl)
end

recipe_array = [
  [
    ['classic', 90, '85F', 'Dry, rustic, yeast-centric, light pear, unadorned.'],
    [
      ['pilsner', nil, 9, nil],
      ['munich', nil, 1, nil],
      ['corn sugar', 'peak krausen', 1, nil],
      ['styrian goldings', 'boil', 1.5, '60 min'],
      ['saaz', 'boil', 0.5, '15 min'],
      ['dupont strain', 'primary', 1, nil]
    ]
  ],
  [
    ['hoppy classic', 90, '85F', 'Dry, grassy, peppery, light pear, earthy.'],
    [
      ['pilsner', nil, 9, nil],
      ['wheat malt', nil, 0.5, nil],
      ['munich', nil, 0.5, nil],
      ['corn sugar', 'peak krausen', 1, nil],
      ['styrian goldings', 'boil', 1.3, '60 min'],
      ['hallertau', 'boil', 1, '15 min'],
      ['styrian goldings', 'boil', 0.7, '1 min'],
      ['saaz', 'dryhop', 1, '5 days'],
      ['dupont strain', 'primary', 1, nil]
    ]
  ],
  [
    ['rye saison', 90, '65-72F', 'Earthy malt character, restrained hops, yeast-forward.'],
    [
      ['pilsner', nil, 6, nil],
      ['rye malt', nil, 3, nil],
      ['munich', nil, 1, nil],
      ['corn sugar', 'peak krausen', 1, nil],
      ['hallertau', 'boil', 1.75, '60 min'],
      ['hallertau', 'boil', 1, '1 min'],
      ['french saison', 'primary', 1, nil]
    ]
  ],
  [
    ['new world', 60, '65-72F', 'Dry, bright, citrus, fruit, peppery.'],
    [
      ['pale malt', nil, 7, nil],
      ['wheat malt', nil, 2, nil],
      ['munich', nil, 1, nil],
      ['turbinado sugar', 'peak krausen', 1, nil],
      ['hallertau', 'boil', 1.5, '60 min'],
      ['amarillo', 'boil', 1, '10 min'],
      ['motueka', 'boil', 1, '1 min'],
      ['amarillo', 'dryhop', 1, '5 days'],
      ['simcoe', 'dryhop', 1, '5 days'],
      ['french saison', 'primary', 1, nil]
    ]
  ],
  [
    ['black saison', 60, '65-72F', 'Complex malt character, mild roast, spicy yeast character.'],
    [
      ['pale malt', nil, 8, nil],
      ['munich', nil, 2, nil],
      ['carafa 2 special', nil, 0.4, nil],
      ['chocolate malt', nil, 0.4, nil],
      ['hallertau', 'boil', 1.5, '60 min'],
      ['american farmhouse', 'primary', 1, nil],
    ]
  ],
  [
    ['pacific 6 grain', 60, '65-72F', 'Bright, clean citrus, crisp, underlying malt complexity.'],
    [
      ['pilsner', nil, 5, nil],
      ['rye', nil, 3, nil],
      ['wheat malt', nil, 1, nil],
      ['flaked oats', nil, 0.5, nil],
      ['munich', nil, 0.5, nil],
      ['rice hulls', nil, 0.15, nil],
      ['corn sugar', nil, 1, nil],
      ['hallertau', 'boil', 1.25, '60 min'],
      ['motueka', 'boil', 1, '20 min'],
      ['motueka', 'boil', 1, '0 min'],
      ['french saison', 'primary', 1, nil],
    ]
  ]
]

recipe_array.each do | recipe_arguments, ingredient_profiles |
  name, boil_length, ferm_temp, description = recipe_arguments
  the_recipe = Recipe.create(name: name, boil_length: boil_length, primary_fermentation_temp: ferm_temp, description: description)
  ingredient_profiles.each_with_object(the_recipe) do | ingredient |
    ingredient_name, usage, quantity, duration = ingredient
    ingr = Ingredient.where(name: ingredient_name).first
    the_recipe.recipe_ingredients.create(usage: usage, quantity: quantity, duration: duration, ingredient_id: ingr)
  end
end
