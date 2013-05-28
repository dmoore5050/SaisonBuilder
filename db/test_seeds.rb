require_relative '../bootstrap_ar'
connect_to 'test'

ingredient_list = [
  ['pilsner', 'Pale base malt, prominent in continental examples.', 'grain'],
  ['pale malt', 'Pale base malt, commonly used in American examples.', 'grain'],
  ['munich', 'Base malt, adds richness. Use to supplement wheat, rye, pilsner, or pale malt.', 'grain'],
  ['white wheat malt', 'Base malt, added to modify malt character. Doughy, mild.', 'grain'],
  ['amarillo', 'New-world hop, floral, tangerine citrus character.', 'hop'],
  ['hallertau', 'Old-world, floral, spicy, refined.', 'hop'],
  ['saaz', 'Old-world, spicy, earthy.', 'hop'],
  ['simcoe', 'New-world, pungent, pine, grapefruit, pineapple.', 'hop'],
  ['styrian goldings', 'Old-world, spicy, mildly floral, fruity.', 'hop'],
  ['motueka', 'New-world, lemon-lime, bright citrus.', 'hop'],
  ['dupont strain', 'Ferment: ~85F, can be slow to finish. Spicy/peppery, mild fruit.', 'yeast', 565, 3724],
  ['french saison', 'Ferment: 65-72F. Aromatic fruit/citrus, peppery, clean.', 'yeast', 656, 3711],
  ['corn sugar', 'Adjunct. Adds no flavor; add to raise gravity without boosting body.', 'adjunct']
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
    ['new world', 60, '65-72F', 'Dry, bright, citrus, fruit, peppery.'],
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
      ['french saison', 'primary', 1, nil]
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