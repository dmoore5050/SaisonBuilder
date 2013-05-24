require_relative '../../bootstrap_ar'

module QuestionSet

  RECIPE_NAME_ARRAY = %w( classic hoppy_classic rye_saison new_world black_saison )
  OPTION_ARRAY = %w( menu list yeast change_primary add_primary blend add_another_strain brett_only brett_secondary grain sweetness roast brown black wheat rye hops flavor_hops aroma_hops gravity other done spices fruit botanicals adjuncts more_botanicals)
  COMPONENTS_ARRAY = %w( dupont french american blend_brett_c blend_brett_b blend_brett_l only_brett_c only_brett_b only_brett_l only_brett_b_trois secondary_brett_b secondary_brett_c secondary_brett_l caramel honey eight seven five four bitterness floral_spicy piney_citrus spicy floral citrus coriander citrus_zest white_peppercorns thai_basil ginger peaches blackberries mango currants hibiscus lavender rose_hips corn_sugar turbinado_sugar rice)

  def self.route(question, trackback)
    puts question
    answer = $stdin.gets.downcase.chomp!.tr(' ', '_')

    if answer.include?('q') || answer.include?('x')
      return
    elsif answer == 'modify'
      modify_trigger = 'mod' # trigger for routing, could be any string
      QuestionSet.list modify_trigger
    elsif OPTION_ARRAY.include? answer
      QuestionSet.send("#{answer}")
    elsif RECIPE_NAME_ARRAY.include? answer
      puts "print recipe...#{answer}"
    elsif COMPONENTS_ARRAY.include? answer
      puts "execute method....#{answer}"
    else
      puts "\n'#{answer}' is not a valid option. Please choose from the choices listed."
      puts "Type 'Menu' to return to Recipes menu, or 'Quit' to exit SaisonBuilder."
      QuestionSet.send("#{trackback}")
    end

  end

  def self.menu
    question = <<EOS

Please choose one of the following options:
     List -    View a list of existing recipes
     Modify -  Modify an existing base recipe

EOS
    QuestionSet.route question, 'menu'
  end

  def self.list(modify_trigger = nil)
    question = <<EOS

Choose a saison recipe:
    Classic -        Dry, rustic, yeast-centric, unadorned
    Hoppy Classic -  Dry, grassy, peppery, earthy
    Rye Saison -     Earthy malt character, restrained hops, yeast-forward
    New World -      Dry, bright, citrus, fruit, peppery
    Black Saison -   Complex malt character, mild roast, spicy yeast character

EOS
    if !modify_trigger.nil?
      QuestionSet.create_modified_recipe question
    else
      QuestionSet.route question, 'use'
    end
  end

  def self.create_modified_recipe(question)
    puts question
    answer = $stdin.gets.downcase.chomp!
    answer[' '] = '_' if answer.include? ' '

    if RECIPE_NAME_ARRAY.include? answer
      puts 'dup the recipe' # placeholder - include actual dup here!!!
      QuestionSet.modify
    else
      puts "\n'#{answer}' is not a valid option. Please choose from the recipes listed."
      puts "Type 'Menu' to return to Recipes menu, or 'Quit' to exit SaisonBuilder."
      modify_trigger = 'mod' # trigger for routing, could be any string
      QuestionSet.list modify_trigger
    end
  end

  def self.modify
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

  def self.yeast
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

  def self.change_primary
    question = <<EOS

Please choose a new primary yeast:
    Dupont -    Dry, spicy, mildly tart/acidic.
    French -    Dry, spicy/peppery, more prominent fruit/citrus
    American -  Trad'l saison yeast pre-blended with Brettanomyces.

EOS
    QuestionSet.route question, 'change_primary'
  end

  def self.add_primary
    question = <<EOS

Please choose an additional primary yeast:
    Dupont -    Dry, spicy, mildly tart/acidic.
    French -    Dry, spicy/peppery, more prominent fruit/citrus
    American -  Trad'l saison yeast pre-blended with Brettanomyces.

EOS
    QuestionSet.route question, 'add_primary'
  end

  def self.blend
    question = <<EOS

Please choose a strain of Brettanomyces:
    Blend Brett C -  Subtle, pineapple/tropical fruit aroma
    Blend Brett B -  Moderate intensity, barnyard, musty
    Blend Brett L -  Intense Brett character, barnyard, horseblanket, dank

EOS
    QuestionSet.route question, 'blend'
  end

  def self.add_another_strain
    question = <<EOS

Would you like to add an additional strain of Brett to blend?
    Add Another Strain -  (return to Brettanomyces menu)
    Yeast -   (return to Yeast menu)

EOS
    QuestionSet.route question, 'add_another_strain'
  end

  def self.brett_only
    question = <<EOS

Please choose a strain of Brettanomyces
(Expect a significantly longer fermentation period when using only Brett):

    Only Brett B Trois -  Delicate Pineapple and tropical fruit, tart.
    Only Brett B -        Barnyard, musty, leather
    Only Brett C -        Pineapple/tropical fruit aroma
    Only Brett L -        Intense, dank, musty, horseblanket

EOS
    QuestionSet.route question, 'brett_only'
  end

  def self.brett_secondary
    question = <<EOS

Please choose a strain of Brettanomyces:
    Secondary Brett C -  Subtle, pineapple/tropical fruit aroma
    Secondary Brett B -  Moderate intensity, barnyard, musty
    Secondary Brett L -  Intense Brett character, barnyard, horseblanket, dank

EOS
    QuestionSet.route question, 'brett_secondary'
  end

  def self.grain
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

  def self.sweetness
    question = <<EOS

Choose a desired sweetness character:
    Caramel -  Subtle caramel character, mild toffee
    Honey -    Subtle honey character

EOS
    QuestionSet.route question, 'sweetness'
  end

  def self.return_to_grain
    question = <<EOS

Would you like to further modify this recipe's grain bill?
    Grain -  Return to Grain menu
    Menu -   Return to Modify menu

EOS
    QuestionSet.route question, 'return_to_grain'
  end

  def self.roast
    question = <<EOS

Choose a desired roast character:
    Brown -  Less roast, more nutty, chocolate character
    Black -  More pronounced roast, light coffee notes

EOS
    QuestionSet.route question, 'roast'
  end

  def self.wheat
   question = <<EOS

Base malt composition has been altered to provide more wheat character.

EOS
    QuestionSet.route question, 'wheat'
  end

  def self.rye
   question = <<EOS

Base malt composition has been altered to provide more rye character.

EOS
    QuestionSet.route question, 'rye'
  end

  def self.gravity
    question = <<EOS

Would you like to increase or decrease the standard 6% gravity of your saison?
    Increase
    Decrease

EOS

    QuestionSet.route question, 'gravity'
  end

  def self.modified
    puts ' '
    puts 'The recipe has been modified to reflect these changes.'
  end

  def self.increase
    question = <<EOS

What is your desired final gravity?
    Eight - 8% ABV
    Seven - 7% ABV

EOS
    QuestionSet.route question, 'increase'
  end

  def self.decrease
    question = <<EOS

What is your desired final gravity?
    Five - 5% ABV
    Four - 4% ABV

EOS
  QuestionSet.route question, 'decrease'
  end

  def self.hops
    question = <<EOS

How would you like to change the hop character?
    Bitterness -   Increase bitterness
    Flavor hops -  Increase flavor/aroma
    Aroma hops -   Increase aroma

EOS
    QuestionSet.route question, 'hops'
  end

  def self.flavor_hops
    question = <<EOS
What kind of hop flavor would you like to add?
    Floral spicy -       Increase flavor/aroma (European hop character)
    Piney citrus -  Increase flavor/aroma (American hop character)

EOS
    QuestionSet.route question, 'flavor_hops'
  end

  def self.aroma_hops
    question = <<EOS
What kind of hop flavor would you like to add?
    Floral -  Increase aroma (Western European)
    Spicy -   Increase aroma (Eastern European)
    Citrus -  Increase aroma (American)

EOS
    QuestionSet.route question, 'aroma_hops'
  end

  def self.addl_hop_changes # ***
    question = <<EOS

Would you like to make any other changes to your hop bill?
    Yes
    No

EOS
    QuestionSet.route question, 'addl_hop_changes'
  end

  def self.other
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

  def self.spices
    question = <<EOS

What spice would you like to add to the recipe?
    Coriander
    Citrus zest
    White peppercorns
    Thai Basil
    Ginger

EOS
    QuestionSet.route question, 'spices'
  end

  def self.more_spices # ***
    question = <<EOS

Would you like to add additional spices?
    Yes
    No

EOS
    QuestionSet.route question, 'more_spices'
  end

  def self.fruit
    question = <<EOS

What fruit would like to add to the recipe?
    Peaches
    Blackberries
    Mango
    Currants

EOS
    QuestionSet.route question, 'fruit'
  end

  def self.more_fruit # ***
    question = <<EOS

Would you like to add additional fruits?
    Yes
    No

EOS
    QuestionSet.route question, 'more_fruit'
  end

  def self.botanicals
    question = <<EOS

What botanical would you like to add to the recipe?
    Hibiscus
    Lavender
    Rose Hips

EOS
    QuestionSet.route question, 'botanicals'
  end

  def self.more_botanicals # ***
    question = <<EOS

Would you like to add additional botanicals?
    Botanicals -  Return to Botanicals menu
    Other -       Return to Other Ingredients menu
    Menu -        Return to Recipes menu

EOS
    QuestionSet.route question, 'more_botanicals'
  end

  def self.adjuncts
    question = <<EOS

What adjunct would you like to add to the recipe?
    Corn Sugar -       Adds to gravity without adding body or flavor.
    Turbinado Sugar -  Can contribute slight molasses character.
    Rice -             Used to lighten body/flavor.

EOS
    QuestionSet.route question, 'adjuncts'
  end

end






