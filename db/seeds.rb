require_relative '../bootstrap_ar'
connect_to 'development'

ingredient_list = [
  ['Pilsner', 'Pale base malt, prominent in continental examples.', 'Grain'],
  ['Pale Malt', 'Pale base malt, commonly used in American examples.', 'Grain'],
  ['Munich', 'Base malt, adds richness. Use to supplement wheat, pilsner, or pale malt.', 'Grain'],
  ['White Wheat Malt', 'Base malt, added to modify malt character. Doughy, mild.', 'Grain'],
  ['Caramunich', 'Caramel malt, adds mild caramel/toffee flavors and sweetness.', 'Grain'],
  ['Honey Malt', 'Specialty malt. Adds distinctive honey-like sweetness.', 'Grain'],
  ['Chocolate Malt', 'Kilned specialty malt. Adds nutty, chocolate flavor and color.', 'Grain'],
  ['Carafa 2 Special', 'Kilned specialty malt. Adds color, mild roasty flavors w/o harshness.', 'Grain'],
  ['Amarillo', 'New-world hop, floral, tangerine citrus character.', 'Hop'],
  ['Hallertau', 'Old-world, floral, spicy, refined.', 'Hop'],
  ['Saaz', 'Old-world, spicy, earthy.', 'Hop'],
  ['Simcoe', 'New-world, pungent, pine, grapefruit, pineapple.', 'Hop'],
  ['Sorachi', 'New-world, clean, string lemon character, bright.', 'Hop'],
  ['Styrian Goldings', 'Old-world, spicy, mildly floral, fruity.', 'Hop'],
  ['Dupont Strain', 'Ferment: ~85F, can be slow to finish. Spicy/peppery, mild fruit.', 'Yeast', 565, 3724],
  ['French Saison', 'Ferment: 65-72F. Aromatic fruit/citrus, peppery, clean.', 'Yeast', 656, 3711],
  ['American Farmhouse', 'Ferment: 65-72F. Saison/Brett blend. Mild pepper, barnyard.', 'Yeast', 670],
  ['Brett. Brux. Trois', 'Ferment: 65-72F. Mild, tart, delicate mango, pineapple.', 'Yeast', 644],
  ['Brett. Brux.', 'Ferment: 65-72F. Moderate intensity, horseblanket, bright lemon.', 'Yeast', 650, 5112],
  ['Brett. Clausenii', 'Ferment: 65-72F. Prominent pineapple/tropical fruit aromatics.', 'Yeast', 645],
  ['Brett. Lambicus', 'Ferment: 65-72F. Intense, barnyard, horseblanket, dank, musty.', 'Yeast', 653, 5526],
  ['Cardamom', 'Adds a citrusy, ginger-like flavor with elements of cinnamon or nutmeg.', 'Spice'],
  ['Citrus Zest', 'Can use an array of varieties - lemon, lime, orange, etc.', 'Spice'],
  ['White Peppercorns', 'Peppery, mild wine-like flavor.', 'Spice'],
  ['Thai Basil', 'Similar to sweet basil, but with notes of licorice.', 'Spice'],
  ['Ginger', 'Clean, warm, woody sweetness, bright.', 'Spice'],
  ['Peaches', 'Add to secondary fermentation.', 'Fruit'],
  ['Blackberries', 'Add to secondary fermentation.', 'Fruit'],
  ['Mango', 'Add to secondary fermentation. Tropical-fruit character, mildly tart.', 'Fruit'],
  ['Currants', 'Tart, raisin-like flavor. Add to secondary fermentation.', 'Fruit'],
  ['Hibiscus', 'Deep red in color, fruity flavor, notes of lemon and ripe berries.', 'Botanical'],
  ['Lavender', 'Floral, spicy, notes of lemon and mint.', 'Botanical'],
  ['Rose Hips', 'Floral, citrusy, sour.', 'Botanical'],
  ['Corn Sugar', 'Adjunct. Adds no flavor; add to raise gravity without boosting body.', 'Adjunct'],
  ['Turbinado Sugar', 'Adjunct. Adds subtle molasses character.', 'Adjunct'],
  ['Rice', 'Adjunct. Adds crispness, lightens body. Cook before adding to mash.', 'Adjunct']
]

ingredient_list.each do | name, description, type_code, yeast_code_wl, yeast_code_wyeast|
  Ingredient.create(name: name, description: description, type_code: type_code, yeast_code_wyeast: yeast_code_wyeast, yeast_code_wl: yeast_code_wl)
end

 # ROUGH DRAFT
recipe_array = [
  [
    ['classic', 90, '85F'], # iteration problem
    [
      ['pilsner', nil, 9, nil],
      ['munich', nil, 1, nil],
      ['corn sugar', 'peak krausen', 1, nil],
      ['styrian goldings', 'boil', 1.5, '60 min'],
      ['saaz', 'boil', 0.5, '15 min'],
      ['dupont', 'primary', nil, nil, 565, 3724]
    ]
  ],
  [
    ['hoppy classic', 90, '85F'],
    [
      ['pilsner', nil, 9, nil],
      ['white wheat malt', nil, 0.5, nil],
      ['munich', nil, 0.5, nil],
      ['corn sugar', 'peak krausen', 1, nil],
      ['styrian goldings', 'boil', 1.3, '60 min'],
      ['hallertau', 'boil', 1, '15 min'],
      ['styrian goldings', 'boil', 0.7, '1 min'],
      ['saaz', 'dryhop', 1, '5 days'],
      ['dupont', 'primary', nil, nil, 565, 3724]
    ]
  ],
  [
    ['rye saison', 90, '65-72F'],
    [
      ['pilsner', nil, 6, nil],
      ['rye malt', nil, 3, nil],
      ['munich', nil, 1, nil],
      ['corn sugar', 'peak krausen', 1, nil],
      ['hallertau', 'boil', 1.75, '60 min'],
      ['hallertau', 'boil', 1, '1 min'],
      ['french', 'primary', nil, nil, 656, 3711]
    ]
  ],
  [
    ['new world', 60, '65-72F'],
    [
      ['pale malt', nil, 7, nil],
      ['white wheat malt', nil, 2, nil],
      ['munich', nil, 1, nil],
      ['turbinado sugar', 'peak krausen', 1, nil],
      ['hallertau', 'boil', 1.5, '60 min'],
      ['amarillo', 'boil', 1, '10 min'],
      ['motueka', 'boil', 1, '1 min'],
      ['amarillo', 'dryhop', 1, '5 days'],
      ['simcoe', 'dryhop', 1, '5 days'],
      ['french', 'primary', nil, nil, 656, 3711]
    ]
  ],
  [
    ['black saison', 60, '65-72F'],
    [
      ['pale malt', nil, 8, nil],
      ['munich', nil, 2, nil],
      ['carafa 2 special', nil, 0.4, nil],
      ['chocolate malt', nil, 0.4, nil],
      ['hallertau', 'boil', 1.5, '60 min'],
      ['american farmhouse', 'primary', nil, nil, 670],
    ]
  ]
]

recipe_array.each do | recipe |
  recipe.each do
    name, boil_length, ferm_temp = recipe[0][0], recipe[0][1], recipe[0][2]
    the_recipe = Recipe.create(name: name, boil_length: boil_length, primary_fermentation_temp: ferm_temp)
    the_recipe.save
    recipe[1].each_with_index do | name, usage, quantity, duration, yeast_code_wl, yeast_code_wyeast |
      puts the_recipe
      the_recipe_ingredient = the_recipe.recipe_ingredient.create(usage: usage, quantity: quantity, duration: duration)
      ingr = Ingredient.where(name: params[:ingredient][:name]).first
      the_recipe_ingredient.ingredient = ingr
      the_recipe_ingredient.save
    end
  end
end


