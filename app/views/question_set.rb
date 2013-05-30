require_relative '../../bootstrap_ar'

class QuestionSet

  attr_reader :record

  unless const_defined?(:RECIPE_NAME_ARRAY) # gets rid of 'constant initialize' error
    RECIPE_NAME_ARRAY = %w( classic hoppy_classic rye_saison new_world black_saison pacific_6_grain)
    OPTION_ARRAY = %w( menu remove list_recipes modify yeast primary blend brett_only brett_secondary grain sweetness roast brown black wheat rye hops flavor aroma gravity increase decrease other spices fruit botanicals adjuncts more_botanicals)
    COMPONENTS_ARRAY = %w( dupont french american blend_brett_c blend_brett_b blend_brett_l only_brett_c only_brett_b only_brett_l only_brett_b_trois secondary_brett_b secondary_brett_c secondary_brett_l caramel honey wheat rye brown black eight seven five four bittering floral_spicy piney_citrus spicy floral citrus coriander citrus_zest white_peppercorns thai_basil ginger peaches blackberries mango currants hibiscus lavender rose_hips corn_sugar turbinado_sugar rice)
  end

  def initialize(record = nil)
    @record = record
  end

  # the <route> method routes every question in the question set, each of which
  # closes with a call back to route. Route then checks the answer to the given
  # question against the constant arrays and routes the answer on its course.
  # Every answer to each question corresponds with a method name, either in
  # question set if it should route to another question, or to ingredient controller
  # if an ingredient change is called for.

  def route(question, trackback)
    puts question
    answer = $stdin.gets.downcase.chomp!.tr(' ', '_')

    if answer.include?('q') || answer.include?('x')
      return
    elsif answer == 'modify_recipe' || answer == 'modify' && trackback == 'menu'
      modify_trigger = 'mod' # trigger for routing, could be any string
      list_recipes modify_trigger
    elsif OPTION_ARRAY.include? answer
      send("#{answer}")
    elsif RECIPE_NAME_ARRAY.include? answer
      params = { recipe: { name: answer.tr('_', ' ') } }
      selected_recipe = RecipeController.new params
      selected_recipe.view
    elsif COMPONENTS_ARRAY.include? answer
      component = RecipeController.new nil, @record
      component.send("#{answer}")
    else
      puts "\n'#{answer}' is not a valid option. Please choose from the choices listed."
      puts "Type 'Menu' to return to Recipes menu, or 'Quit' to exit SaisonBuilder."
      send("#{trackback}")
    end

  end

  # ***************************************** #
  #             vv  QUESTIONS vv
  # ***************************************** #

  def menu
    question = <<EOS

Please choose one of the following options:
     List Recipes -   View a list of existing recipes
     Modify Recipe -  Modify an existing base recipe

EOS
    route question, 'menu'
  end

  def list_recipes(modify_trigger = nil)
    question = <<EOS

Choose a saison recipe:
    Classic -          Dry, rustic, yeast-centric, light pear, unadorned
    Hoppy Classic -    Dry, grassy, peppery, light pear, earthy
    Rye Saison -       Earthy malt character, restrained hops, yeast-forward
    New World -        Dry, bright, citrus, fruit, peppery
    Black Saison -     Complex malt character, mild roast, spicy yeast character
    Pacific 6 Grain -  Bright, clean citrus, crisp, underlying malt complexity

EOS
    check_modify_trigger modify_trigger, question
  end

  def check_modify_trigger(modify_trigger, question)
    if !modify_trigger.nil?
      create_modified_recipe question
    else
      route question, 'list_recipes'
    end
  end

  def create_modified_recipe(question)
    puts question
    answer = $stdin.gets.downcase.chomp!

    if RECIPE_NAME_ARRAY.include? answer.tr(' ', '_')
      clone_recipe answer
      modify
    else
      invalid_recipe_message answer
    end
  end

  def clone_recipe(answer)
    puts "\nPlease give your new recipe a unique name:\n\n"
    new_name = $stdin.gets.downcase.chomp!
    puts "\nPlease enter a short description for your new recipe:\n\n"
    descr = $stdin.gets.downcase.chomp!
    base_recipe = Recipe.where(name: answer).first
    new_recipe = base_recipe.dup
    check_unique_name new_name, new_recipe, descr, answer
    @record = new_recipe
    new_recipe.save

    clone_recipe_ingredients base_recipe, new_recipe
  end

  def clone_recipe_ingredients(base_recipe, new_recipe)
    ingr_array = RecipeIngredient.where(recipe_id: base_recipe.id)
    ingr_array.each do | recipe_ingr_record |
      new_recipe_ingr = recipe_ingr_record.dup
      new_recipe_ingr[:recipe_id] = new_recipe.id
      new_recipe_ingr.save
    end
  end

  def check_unique_name(new_name, new_recipe, descr, answer)
    name_check = Recipe.where(name: new_name).first
    if name_check.nil?
      new_recipe[:name] = new_name
      new_recipe[:description] = descr
    else
      puts "#{answer} is already in use. Please choose another.\n"
      clone_recipe answer
    end
  end

  def invalid_recipe_message(answer)
    puts "\n'#{answer}' is not a valid option. Please choose from the recipes listed."
    puts "Type 'Menu' to return to Recipes menu, or 'Quit' to exit SaisonBuilder."
    modify_trigger = 'mod' # trigger for routing, actual string is arbitrary
    list_recipes modify_trigger
  end

  def modify
    question = <<EOS

What aspect of the recipe would you like to change?
    Remove -   Remove an item from the recipe
    Yeast -    Change or add yeast
    Grain -    Change or add to grain bill
    Gravity -  Raise or lower gravity of recipe
    Hops -     Add add'l hops to recipe
    Other -    Other ingredients (spice, fruit, botanicals)
    Quit -     I'm finished modifying this recipe

EOS
    route question, 'modify'
  end

  def remove
    list, usage, duration = '', nil, nil
    build_remove_list list
    question = %Q(
Which item would you like to delete from the recipe?
#{list}

If usage and duration are present, please answer in the form of name, usage, duration.
Ex: Amarillo, boil, 30 min
)
    puts question
    name, usage, duration = $stdin.gets.downcase.chomp!.split(', ')
    component = RecipeController.new nil, @record
    component.remove name, usage, duration
  end

  def build_remove_list(list)
    ingr_array = RecipeIngredient.where(recipe_id: @record).all
    ingr_array.each do | ingredient |
      ingredient_match = Ingredient.where(id: ingredient.ingredient_id).first
      list << "    #{ingredient_match.name.titleize.ljust(21)}#{ingredient.usage} #{ingredient.duration}\n"
    end
  end

  def remove_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished removing ingredients?
    Remove -  No, I would like to remove another ingredient.
    Modify -  Yes, take me back to the Modify Recipe menu.
    Quit -    I want to exit SaisonBuilder.

EOS
    route question, 'remove_redirect_menu'
  end

  def yeast
    question = <<EOS

Please choose one:
    Primary -          Change the primary yeast used
    Blend -            Blend Brettanomyces with my primary yeast
    Brett Only -       Use only Brettanomyces for fermentation
    Brett Secondary -  Use Brett for secondary fermentation
    Modify -           Return to Modify Recipe menu

EOS
    route question, 'primary'
  end

  def primary
    question = <<EOS

Please choose a new primary yeast:
    Dupont -    Dry, spicy, mildly tart/acidic.
    French -    Dry, spicy/peppery, more prominent fruit/citrus
    American -  Trad'l saison yeast blended with Brettanomyces.

EOS
    route question, 'primary'
  end

  def blend
    question = <<EOS

Please choose a strain of Brettanomyces:
    Blend Brett C -  Subtle, pineapple/tropical fruit aroma
    Blend Brett B -  Moderate intensity, barnyard, musty
    Blend Brett L -  Intense Brett character, barnyard, horseblanket, dank

EOS
    route question, 'blend'
  end

  def brett_only
    question = <<EOS

Please choose a strain of Brettanomyces
(Expect a significantly longer fermentation period when using only Brett):

    Only Brett B Trois -  Delicate Pineapple and tropical fruit, tart.
    Only Brett B -        Barnyard, musty, leather
    Only Brett C -        Pineapple/tropical fruit aroma
    Only Brett L -        Intense, dank, musty, horseblanket

EOS
    route question, 'brett_only'
  end

  def brett_secondary
    question = <<EOS

Please choose a strain of Brettanomyces:
    Secondary Brett C -  Subtle, pineapple/tropical fruit aroma
    Secondary Brett B -  Moderate intensity, barnyard, musty
    Secondary Brett L -  Intense Brett character, barnyard, horseblanket, dank

EOS
    route question, 'brett_secondary'
  end

  def yeast_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished modifying your recipe's yeast bill?
    Yeast -   No, take me back to the Yeast modification menu.
    Modify -  Yes, take me back to the Modify Recipe menu.
    Quit -    I want to exit SaisonBuilder.

EOS
    route question, 'yeast_redirect_menu'
  end

  def grain
    question = <<EOS

How would you like to alter malt character:
    Sweetness -  Add sweetness to recipe
    Roast -      Increase roast
    Wheat -      Increase wheat character (doughy)
    Rye -        Increase rye character (earthy, robust)
    Modify -     I'm finished modifying malt character (return to Modify menu)

EOS
    route question, 'grain'
  end

  def sweetness
    question = <<EOS

Choose a desired sweetness character:
    Caramel -  Subtle caramel character, mild toffee
    Honey -    Subtle honey character

EOS
    route question, 'sweetness'
  end

  def roast
    question = <<EOS

Choose a desired roast character:
    Brown -  Less roast, more nutty, chocolate character
    Black -  More pronounced roast, light coffee notes

EOS
    route question, 'roast'
  end

  def brown
    puts "\nAdding dark malt character to recipe..."
    component = RecipeController.new nil, @record
    component.brown
  end

  def black
    puts "\nAdding dark malt character to recipe..."
    component = RecipeController.new nil, @record
    component.black
  end

  def wheat
    puts "\nChanging base malt composition to add wheat character..."
    component = RecipeController.new nil, @record
    component.wheat
  end

  def rye
    puts "\nChanging base malt composition to add rye character..."
    component = RecipeController.new nil, @record
    component.rye
  end

  def grain_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished modifying your recipe's grain bill?
    Grain -   No, take me back to the Grain modification menu.
    Modify -  Yes, take me back to the Modify Recipe menu.
    Quit -    I want to exit SaisonBuilder.

EOS
    route question, 'grain_redirect_menu'
  end

  def gravity
    question = <<EOS

Would you like to increase or decrease the standard 6% gravity of your saison?
    Increase
    Decrease

EOS
    route question, 'gravity'
  end

  def increase
    question = <<EOS

What is your desired final gravity?
    Eight - 8% ABV
    Seven - 7% ABV

EOS
    route question, 'increase'
  end

  def decrease
    question = <<EOS

What is your desired final gravity?
    Five - 5% ABV
    Four - 4% ABV

EOS
    route question, 'decrease'
  end

  def gravity_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished modifying your recipe?
    Modify -  No, take me back to the Modify Recipe menu.
    Quit -    Yes, I want to exit SaisonBuilder.

EOS
    route question, 'gravity_redirect_menu'
  end

  def hops
    question = <<EOS

How would you like to change the hop character?
    Bittering -  Increase bitterness
    Flavor -     Increase flavor, some aroma
    Aroma -      Increase aroma

EOS
    route question, 'hops'
  end

  def flavor
    question = <<EOS
What kind of hop flavor would you like to add?
    Floral spicy -  Increase flavor/aroma (European hop character)
    Piney citrus -  Increase flavor/aroma (American hop character)

EOS
    route question, 'flavor'
  end

  def aroma
    question = <<EOS
What kind of hop aroma would you like to add?
    Floral -  Increase aroma (Western European)
    Spicy -   Increase aroma (Eastern European)
    Citrus -  Increase aroma (American)

EOS
    route question, 'aroma_hops'
  end

  def hops_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished modifying your recipe's hops bill?
    Hops -    No, take me back to the Hops modification menu.
    Modify -  Yes, take me back to the Modify Recipe menu.
    Quit -    I want to exit SaisonBuilder.

EOS
    route question, 'hops_redirect_menu'
  end

  def other
    question = <<EOS

What type of additional ingredient would you like to add?
    Spices -      Add spice(s)
    Fruit -       Add fruit
    Botanicals -  Add botanical(s)
    Adjuncts -    Add adjuncts
    Menu -        Return to Recipes menu

EOS
    route question, 'other'
  end

  def spices
    question = <<EOS

What spice would you like to add to the recipe?
    Coriander
    Citrus zest
    White peppercorns
    Thai Basil
    Ginger

EOS
    route question, 'spices'
  end

  def spices_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished adding Spices to your recipe?
    Spices -   No, take me back to the spices modification menu.
    Modify -   Yes, take me back to the Modify Recipe menu.
    Other -    Yes, take me back to the Other Ingredients menu.
    Quit -     I want to exit SaisonBuilder.

EOS
    route question, 'spices_redirect_menu'
  end

  def fruit
    question = <<EOS

What fruit would like to add to the recipe?
    Peaches
    Blackberries
    Mango
    Currants

EOS
    route question, 'fruit'
  end

  def fruit_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished adding Fruit to your recipe?
    Fruit -    No, take me back to the Fruit modification menu.
    Other -    Yes, take me back to the Other Ingredients menu.
    Modify -   Yes, take me back to the Modify Recipe menu.
    Quit -     I want to exit SaisonBuilder.

EOS
    route question, 'fruit_redirect_menu'
  end

  def botanicals
    question = <<EOS

What botanical would you like to add to the recipe?
    Hibiscus
    Lavender
    Rose Hips

EOS
    route question, 'botanicals'
  end

  def botanicals_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished adding Botanicals to your recipe?
    Botanicals -  No, take me back to the Botanicals modification menu.
    Other -       Yes, take me back to the Other Ingredients menu.
    Modify -      Yes, take me back to the Modify Recipe menu.
    Quit -        I want to exit SaisonBuilder.

EOS
    route question, 'botanicals_redirect_menu'
  end

  def adjuncts
    question = <<EOS

What adjunct would you like to add to the recipe?
    Corn Sugar -       Adds to gravity without adding body or flavor.
    Turbinado Sugar -  Can contribute slight molasses character.
    Rice -             Used to lighten body/flavor.

EOS
    route question, 'adjuncts'
  end

  def adjunct_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished adding Adjuncts to your recipe?
    Adjuncts -  No, take me back to the Adjuncts modification menu.
    Other -     Yes, take me back to the Other Ingredients menu.
    Modify -    Yes, take me back to the Modify Recipe menu.
    Quit -      I want to exit SaisonBuilder.

EOS
    route question, 'adjunct_redirect_menu'
  end

end






