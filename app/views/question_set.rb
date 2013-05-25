require_relative '../../bootstrap_ar'

module QuestionSet

  RECIPE_NAME_ARRAY = %w( classic hoppy_classic rye_saison new_world black_saison )
  OPTION_ARRAY = %w( menu list yeast change_primary add_primary blend add_another_strain brett_only brett_secondary grain sweetness roast brown black wheat rye hops flavor_hops aroma_hops gravity other done spices fruit botanicals adjuncts more_botanicals)
  COMPONENTS_ARRAY = %w( dupont french american blend_brett_c blend_brett_b blend_brett_l only_brett_c only_brett_b only_brett_l only_brett_b_trois secondary_brett_b secondary_brett_c secondary_brett_l caramel honey wheat rye brown black eight seven five four bitterness floral_spicy piney_citrus spicy floral citrus coriander citrus_zest white_peppercorns thai_basil ginger peaches blackberries mango currants hibiscus lavender rose_hips corn_sugar turbinado_sugar rice)

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
      component = IngredientController.new
      component.send("#{answer}")
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

    if RECIPE_NAME_ARRAY.include? answer.tr(' ', '_')
      QuestionSet.clone_recipe answer
      QuestionSet.modify
    else
      QuestionSet.invalid_recipe_message
    end
  end

  def self.clone_recipe(answer)
    puts "\nPlease give your new recipe a unique name:\n\n"
    new_name = $stdin.gets.downcase.chomp!
    base_recipe = Recipe.where(name: answer).first
    new_recipe = base_recipe.dup
    new_recipe[:name] = new_name
    new_recipe.save

    QuestionSet.clone_recipe_ingredients base_recipe, new_recipe
  end

  def self.clone_recipe_ingredients(base_recipe, new_recipe)
    ingr_array = RecipeIngredient.where(recipe_id: base_recipe.id)
    ingr_array.each do | recipe_ingr_record |
      new_recipe_ingr = recipe_ingr_record.dup
      new_recipe_ingr[:recipe_id] = new_recipe.id
      new_recipe_ingr.save
    end
  end

  def self.invalid_recipe_message
    puts "\n'#{answer}' is not a valid option. Please choose from the recipes listed."
    puts "Type 'Menu' to return to Recipes menu, or 'Quit' to exit SaisonBuilder."
    modify_trigger = 'mod' # trigger for routing, actual string is arbitrary
    QuestionSet.list modify_trigger
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

  def self.yeast_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished modifying your recipe's yeast bill?
    Yeast -   No, take me back to the Yeast modification menu.
    Modify -  Yes, take me back to the Modify Recipe menu.
    Quit -    I want to exit SaisonBuilder.

EOS

    QuestionSet.route question, 'yeast_redirect_menu'
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

  def self.roast
    question = <<EOS

Choose a desired roast character:
    Brown -  Less roast, more nutty, chocolate character
    Black -  More pronounced roast, light coffee notes

EOS
    QuestionSet.route question, 'roast'
  end

  def self.brown
    puts "\nAdding dark malt character to recipe..."
    component = IngredientController.new
    component.brown
  end

  def self.black
    puts "\nAdding dark malt character to recipe..."
    component = IngredientController.new
    component.black
  end

  def self.wheat
    puts "\nChanging base malt composition to add wheat character..."
    component = IngredientController.new
    component.wheat
  end

  def self.rye
    puts "\nChanging base malt composition to add rye character..."
    component = IngredientController.new
    component.rye
  end

  def self.grain_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished modifying your recipe's grain bill?
    Grain -   No, take me back to the Grain modification menu.
    Modify -  Yes, take me back to the Modify Recipe menu.
    Quit -    I want to exit SaisonBuilder.

EOS

    QuestionSet.route question, 'grain_redirect_menu'
  end

  def self.gravity
    question = <<EOS

Would you like to increase or decrease the standard 6% gravity of your saison?
    Increase
    Decrease

EOS

    QuestionSet.route question, 'gravity'
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

  def self.gravity_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished modifying your recipe?
    Modify -  No, take me back to the Modify Recipe menu.
    Quit -    Yes, I want to exit SaisonBuilder.

EOS

    QuestionSet.route question, 'gravity_redirect_menu'
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

  def self.hops_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished modifying your recipe's hops bill?
    Hops -   No, take me back to the Hops modification menu.
    Modify - Yes, take me back to the Modify Recipe menu.
    Quit -   I want to exit SaisonBuilder.

EOS

    QuestionSet.route question, 'hops_redirect_menu'
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

  def self.spices_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished adding Spices to your recipe?
    Spices -   No, take me back to the spices modification menu.
    Modify -   Yes, take me back to the Modify Recipe menu.
    Other -    Yes, take me back to the Other Ingredients menu.
    Quit -     I want to exit SaisonBuilder.

EOS

    QuestionSet.route question, 'spices_redirect_menu'
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

  def self.fruit_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished adding Fruit to your recipe?
    Fruit -    No, take me back to the Fruit modification menu.
    Other -    Yes, take me back to the Other Ingredients menu.
    Modify -   Yes, take me back to the Modify Recipe menu.
    Quit -     I want to exit SaisonBuilder.

EOS

    QuestionSet.route question, 'fruit_redirect_menu'
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

  def self.botanicals_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished adding Botanicals to your recipe?
    Botanicals -  No, take me back to the Botanicals modification menu.
    Other -       Yes, take me back to the Other Ingredients menu.
    Modify -      Yes, take me back to the Modify Recipe menu.
    Quit -        I want to exit SaisonBuilder.

EOS

    QuestionSet.route question, 'botanicals_redirect_menu'
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

  def self.adjuncts_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished adding Adjuncts to your recipe?
    Adjuncts -  No, take me back to the Adjuncts modification menu.
    Other -     Yes, take me back to the Other Ingredients menu.
    Modify -    Yes, take me back to the Modify Recipe menu.
    Quit -      I want to exit SaisonBuilder.

EOS

    QuestionSet.route question, 'adjuncts_redirect_menu'
  end

end






