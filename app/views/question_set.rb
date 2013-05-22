module QuestionSet

  RECIPE_ARRAY = [ 'classic', 'hoppy_classic', 'rye_saison', 'new_world', 'black_saison' ]
  OPTION_ARRAY = [ 'menu', 'use', 'modify', 'yeast', 'change_primary', 'add_primary', 'blend', 'add_another_strain', 'brett_only', 'brett_secondary', 'grain', 'sweetness', 'roast', 'brown', 'black', 'wheat', 'rye', 'hops', 'gravity', 'other', 'done', 'spices', 'fruit', 'botanicals', 'adjuncts', 'more_botanicals']
  COMPONENTS_ARRAY = [ 'dupont', 'french', 'american', 'brett_c', 'brett_b', 'brett_l', 'brett_b_trois', 'caramel', 'honey', '7.5%', '8.5%', '5.5%', '4.5%', '3.5%', 'bitterness', 'cardamom', 'citrus_zest', 'white_peppercorns', 'thai_basil', 'ginger', 'peaches', 'blackberries', 'mango', 'currants', 'hibiscus', 'lavender', 'rose_hips', 'corn_sugar', 'turbinado_sugar', 'rice']

  def QuestionSet.route(question, trackback)

    puts question
    answer = $stdin.gets.downcase.chomp!
    answer[' '] = '_' if answer.include? ' '

    if answer.include?('q') || answer.include?('x')
      return
    elsif OPTION_ARRAY.include? answer
      QuestionSet.send("#{answer}")
    elsif RECIPE_ARRAY.include? answer
      puts "print recipe...#{answer}"
    elsif COMPONENTS_ARRAY.include? answer
      puts "execute method....#{answer}"
    else
      puts "\n'#{answer}' is not a valid option. Please choose from the choices listed."
      puts "Type 'Menu' to return to Recipes menu, or 'Quit' to exit SaisonBuilder."
      QuestionSet.send("#{trackback}")
    end

  end

  def QuestionSet.menu
    question = <<EOS

Please choose one of the following options:
     Use -     Use an existing recipe
     Modify -  Modify an existing base recipe

EOS
    QuestionSet.route question, 'menu'
  end

  def QuestionSet.use
    question = <<EOS

Choose a saison recipe:
    Classic -        Dry, rustic, yeast-centric, unadorned
    Hoppy Classic -  Dry, grassy, peppery, earthy
    Rye Saison -     Earthy malt character, restrained hops, yeast-forward
    New World -      Dry, bright, citrus, fruit, peppery
    Black Saison -   Complex malt character, mild roast, spicy yeast character

EOS
    QuestionSet.route question, 'use'
  end

  def QuestionSet.modify
    question = <<EOS

What aspect of the recipe would you like to change?
    Yeast -    Change or add yeast
    Grain -    Change or add to grain bill
    Gravity -  Raise or lower gravity of recipe
    Hops -     Add add'l hops to recipe
    Other -    Other ingredients (spice, fruit, botanicals)
    Done -     I'm finished modifying this recipe

EOS
    QuestionSet.route question, 'modify'
  end

  def QuestionSet.yeast
    question = <<EOS

Please choose one:
    Change Primary -   Change the primary yeast used
    Add Primary -      Add an additional primary yeast
    Blend -            Blend Brettanomyces with my primary yeast
    Brett Only -       Use only Brettanomyces for fermentation
    Brett Secondary -  Use Brett for secondary fermentation
    Done -             Return to Modify Recipe menu

EOS
    QuestionSet.route question, 'primary'
  end

  def QuestionSet.change_primary
    question = <<EOS

Please choose a new primary yeast:
    Dupont -    Dry, spicy, mildly tart/acidic.
    French -    Dry, spicy/peppery, more prominent fruit/citrus
    American -  Trad'l saison yeast pre-blended with Brettanomyces.

EOS
    QuestionSet.route question, 'change_primary'
  end

  def QuestionSet.add_primary
    question = <<EOS

Please choose an additional primary yeast:
    Dupont -    Dry, spicy, mildly tart/acidic.
    French -    Dry, spicy/peppery, more prominent fruit/citrus
    American -  Trad'l saison yeast pre-blended with Brettanomyces.

EOS
    QuestionSet.route question, 'add_primary'
  end

  def QuestionSet.blend
    question = <<EOS

Please choose a strain of Brettanomyces:
    Brett C -  Subtle, pineapple/tropical fruit aroma
    Brett B -  Moderate intensity, barnyard, musty
    Brett L -  Intense Brett character, barnyard, horseblanket, dank

EOS
    QuestionSet.route question, 'blend'
  end

  def QuestionSet.add_another_strain
    question = <<EOS

Would you like to add an additional strain of Brett to blend?
    Add Another Strain -  (return to Brettanomyces menu)
    Yeast -   (return to Yeast menu)

EOS
    QuestionSet.route question, 'add_another_strain'
  end

  def QuestionSet.brett_only
    question = <<EOS

Please choose a strain of Brettanomyces (please expect a significantly longer fermentation period when using only Brett):

    Brett B Trois -  Delicate Pineapple and tropical fruit, tart.
    Brett B -        Barnyard, musty, leather
    Brett C -        Pineapple/tropical fruit aroma
    Brett L -        Intense, dank, musty, horseblanket

EOS
    QuestionSet.route question, 'brett_only'
  end

  def QuestionSet.brett_secondary
    question = <<EOS

Please choose a strain of Brettanomyces:
    Brett C -  Subtle, pineapple/tropical fruit aroma
    Brett B -  Moderate intensity, barnyard, musty
    Brett L -  Intense Brett character, barnyard, horseblanket, dank

EOS
    QuestionSet.route question, 'brett_secondary'
  end

  def QuestionSet.grain
    question = <<EOS

How would you like to alter malt character:
    Sweetness -  Add sweetness to recipe
    Roast -      Increase roast
    Wheat -      Increase wheat character (doughy)
    Rye -        Increase rye character (earthy, robust)
    Done -       I'm finished modifying malt character (return to Modify menu)

EOS
    QuestionSet.route question, 'grain'
  end

  def QuestionSet.sweetness
    question = <<EOS

Choose a desired sweetness character:
    Caramel -  Subtle caramel character, mild toffee
    Honey -    Subtle honey character

EOS
    QuestionSet.route question, 'sweetness'
  end

  def QuestionSet.return_to_grain
    question = <<EOS

Would you like to further modify this recipe's grain bill?
    Grain -  Return to Grain menu
    Menu -   Return to Modify menu

EOS
    QuestionSet.route question, 'return_to_grain'
  end

  def QuestionSet.roast
    question = <<EOS

Choose a desired roast character:
    Brown -  Less roast, more nutty, chocolate character
    Black -  More pronounced roast, light coffee notes

EOS
    QuestionSet.route question, 'roast'
  end

  def QuestionSet.wheat
   question = <<EOS

Base malt composition has been altered to provide more wheat character.

EOS
    QuestionSet.route question, 'wheat'
  end

  def QuestionSet.rye
   question = <<EOS

Base malt composition has been altered to provide more rye character.

EOS
    QuestionSet.route question, 'rye'
  end

  def QuestionSet.gravity
    question = <<EOS

Would you like to increase or decrease the standard 6.5% gravity of your saison:
    Increase
    Decrease

EOS

    QuestionSet.route question, 'gravity'
  end

  def QuestionSet.modified
    puts ' '
    puts 'The recipe has been modified to reflect these changes.'
  end

   def QuestionSet.increase
    question = <<EOS

What is your desired final gravity?
    7.5%
    8.5%

EOS
    QuestionSet.route question, 'increase'
  end

  def QuestionSet.decrease
    question = <<EOS

What is your desired final gravity?
    5.5%
    4.5%
    3.5%

EOS
  QuestionSet.route question, 'decrease'
  end

  def QuestionSet.hops
    question = <<EOS

How would you like to change the hop character?
    Bitterness -    Increase bitterness
    Flavor(Euro) -  Increase flavor/aroma (European hop character)
    Flavor(US) -    Increase flavor/aroma (American hop character)
    Aroma(Euro) -   Increase aroma (European hop character)
    Aroma(US) -     Increase aroma (American hop character)

EOS
    QuestionSet.route question, 'hops'
  end

  def QuestionSet.addl_hop_changes #***
    question = <<EOS

Would you like to make any other changes to your hop bill?
    Yes
    No

EOS
    QuestionSet.route question, 'addl_hop_changes'
  end

  def QuestionSet.other
    question = <<EOS

What type of additional ingredient would you like to add?
    Spices -      Add spice(s)
    Fruit -       Add fruit
    Botanicals -  Add botanical(s)
    Adjuncts -    Add adjuncts
    Menu -        Return to Recipes menu

EOS
    QuestionSet.route question, 'other'
  end

  def QuestionSet.spices
    question = <<EOS

What spice would you like to add to the recipe?
    Cardamom
    Citrus zest
    White peppercorns
    Thai Basil
    Ginger

EOS
    QuestionSet.route question, 'spices'
  end

  def QuestionSet.more_spices #***
    question = <<EOS

Would you like to add additional spices?
    Yes
    No

EOS
    QuestionSet.route question, 'more_spices'
  end

  def QuestionSet.fruit
    question = <<EOS

What fruit would like to add to the recipe?
    Peaches
    Blackberries
    Mango
    Currants

EOS
    QuestionSet.route question, 'fruit'
  end

  def QuestionSet.more_fruit #***
    question = <<EOS

Would you like to add additional fruits?
    Yes
    No

EOS
    QuestionSet.route question, 'more_fruit'
  end

  def QuestionSet.botanicals
    question = <<EOS

What botanical would you like to add to the recipe?
    Hibiscus
    Lavender
    Rose Hips

EOS
    QuestionSet.route question, 'botanicals'
  end

  def QuestionSet.more_botanicals #***
    question = <<EOS

Would you like to add additional botanicals?
    Botanicals -  Return to Botanicals menu
    Other -       Return to Other Ingredients menu
    Menu -        Return to Recipes menu

EOS
    QuestionSet.route question, 'more_botanicals'
  end

  def QuestionSet.adjuncts
    question = <<EOS

What adjunct would you like to add to the recipe?
    Corn Sugar -       Adds to gravity without adding body or flavor.
    Turbinado Sugar -  Can contribute slight molasses character.
    Rice -             Used to lighten body/flavor.

EOS
    QuestionSet.route question, 'adjuncts'
  end

end






