module QuestionSet

   def QuestionSet.use_or_modify
    question = <<EOS

Please choose one of the following options:
     Use -     Use a pre-configured recipe.
     Modify -  Modify a pre-configured base recipe to my specifications.
EOS
    puts question
  end

   def QuestionSet.choose_recipe
    question = <<EOS

Choose a saison recipe:
    Classic -          Dry, rustic, yeast-centric, unadorned
    Old-world hoppy -  Dry, grassy, peppery, earthy
    Rye Saison -       Earthy malt character, restrained hops, yeast-forward
    New-world hoppy -  Dry, bright, citrus, fruit, peppery
    Black Saison -     Complex malt character, mild roast, spicy yeast character
EOS
    puts question
  end

   def QuestionSet.modify_options
    question = <<EOS

What aspect of the recipe would you like to change?
    Yeast -    Change or add yeast
    Grains -   Change or add to grain bill
    Gravity -  Raise or lower gravity of recipe
    Hops -     Add add'l hops to recipe
    Other -    Other ingredients (spice, fruit, botanicals)
    Done -     I'm finished modifying this recipe
EOS
    puts question
  end

   def QuestionSet.yeast_options
    question = <<EOS

Please choose one:
    Primary -          Change the primary yeast used
    Add_Primary -      Add an additional primary yeast
    Blend -            Blend Brettanomyces with my primary yeast
    Only_Brett -       Use only Brettanomyces for fermentation
    Secondary_Brett -  Use Brett for secondary fermentation
    Done -             I'm finished modifying yeast selection (return to Modify menu)
EOS
    puts question
  end

   def QuestionSet.change_primary
    question = <<EOS

Please choose a new primary yeast:
    Classic -             Dry, spicy, mildly tart/acidic.
    French -              Dry, spicy/peppery, more prominent fruit/citrus
    American Farmhouse -  Trad'l saison yeast pre-blended with Brettanomyces.
EOS
    puts question
  end

   def QuestionSet.addl_primary
    question = <<EOS

Please choose an additional primary yeast:
    Classic -             Dry, spicy, mildly tart/acidic.
    French -              Dry, spicy/peppery, more prominent fruit/citrus
    American Farmhouse -  Trad'l saison yeast pre-blended with Brettanomyces.
EOS
    puts question
  end

   def QuestionSet.blend_brett
    question = <<EOS

Please choose a strain of Brettanomyces:
    B. Claussenii -    Subtle, pineapple/tropical fruit aroma
    B. Bruxellensis -  Moderate intensity, barnyard, musty
    B. Lambicus -      Intense Brett character, barnyard, horseblanket, dank
EOS
    puts question
  end

   def QuestionSet.addl_blend_brett
    question = <<EOS

Would you like to add an additional strain of Brett to blend?
    Yes -  (return to Brettanomyces menu)
    No -   (return to Yeast menu)
EOS
    puts question
  end

   def QuestionSet.brett_primary
    question = <<EOS

Please choose a strain of Brettanomyces (please expect a significantly longer fermentation period when using only Brett):

    B. Bruxellensis Trois -  Delicate Pineapple and tropical fruit, tart.
    B. Bruxellensis -        Barnyard, musty, leather
    B. Clausenii -           Pineapple/tropical fruit aroma
    B. Lambicus -            Intense, dank, musty, horseblanket
EOS
    puts question
  end

   def QuestionSet.grain_options
    question = <<EOS

How would you like to alter malt character:
    Sweeter -   Increase sweetness
    Roastier -  Increase roast
    Wheat -     Increase wheat character (doughy)
    Rye -       Increase rye character (earthy, robust)
    Done -      I'm finished modifying malt character (return to Modify menu)
EOS
    puts question
  end

   def QuestionSet.add_sweetness
    question = <<EOS

Choose a desired sweetness character:
    Caramel -  Subtle caramel character, mild toffee
    Honey -    Subtle honey character
EOS
    puts question
  end

   def QuestionSet.return_to_grain_options
    question = <<EOS

Would you like to further modify this recipe's grain bill?
    Yes -  Return to Grain menu
    No -   Return to Modify menu
EOS
    puts question
  end

   def QuestionSet.increase_roast
    question = <<EOS

Choose a desired roast character:
    Brown -  Less roast, more nutty, chocolate character
    Black -  More pronounced roast, coffee notes
EOS
    puts question
  end

  def QuestionSet.add_wheat
   question = <<EOS

Base malt composition has been altered to provide more wheat character.
EOS
    puts question
  end

  def QuestionSet.add_rye
   question = <<EOS

Base malt composition has been altered to provide more rye character.
EOS
    puts question
  end

   def QuestionSet.gravity_options
    question = <<EOS

Would you like to increase or decrease the standard 6.5% gravity of your saison:
    Increase
    Decrease
EOS

    puts question
  end

   def QuestionSet.recipe_modified_mssg
    puts ' '
    puts 'The recipe has been modified to reflect these changes.'
  end

   def QuestionSet.increase_gravity
    question = <<EOS

What is your desired final gravity?
    7.5%
    8.5%
EOS
    puts question
  end

   def QuestionSet.decrease_gravity
    question = <<EOS

What is your desired final gravity?
    5.5%
    4.5%
    3.5%
EOS
  puts question
  end

   def QuestionSet.hop_options
    question = <<EOS

How would you like to change the hop character?
    IBU -           Increase bitterness
    Flavor(Euro) -  Increase flavor/aroma (European hop character)
    Flavor(US) -    Increase flavor/aroma (American hop character)
    Aroma(Euro) -   Increase aroma (European hop character)
    Aroma(US) -     Increase aroma (American hop character)
EOS
    puts question
  end

   def QuestionSet.addl_hop_changes
    question = <<EOS

Would you like to make any other changes to your hop bill?
    Yes
    No
EOS
    puts question
  end

   def QuestionSet.other_ingr_options
    question = <<EOS

What type of additional ingredient would you like to add?
    Spices -      Add spice(s)
    Fruit -       Add fruit
    Botanicals -  Add botanical(s)
    Done -        I'm finished adding additional ingredients
EOS
    puts question
  end

   def QuestionSet.add_spices
    question = <<EOS

What spice would you like to add to the recipe?
    Cardamom
    Citrus zest
    White peppercorns
    Thai Basil
    Ginger
EOS
    puts question
  end

   def QuestionSet.more_spices
    question = <<EOS

Would you like to add additional spices?
    Yes
    No
EOS
    puts question
  end

   def QuestionSet.add_fruit
    question = <<EOS

What fruit would like to add to the recipe?
    Peaches
    Blackberries
    Mango
    Currants
EOS
    puts question
  end

   def QuestionSet.more_fruit
    question = <<EOS

Would you like to add additional fruits?
    Yes
    No
EOS
    puts question
  end

   def QuestionSet.add_botanicals
    question = <<EOS

What botanicals would like to add to the recipe?
    Hibiscus
    Lavender
    Rose Hips
EOS
    puts question
  end

   def QuestionSet.more_botanicals
    question = <<EOS

Would you like to add additional botanicals?
   Yes
   No
EOS
    puts question
  end

end