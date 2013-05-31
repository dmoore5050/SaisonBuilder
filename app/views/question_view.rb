require_relative '../../bootstrap_ar'

class QuestionView

  attr_reader :record

  def initialize(record = nil)
    @record = record
  end

  def menu
    question = <<EOS

Please choose one of the following options:
     List Recipes -   View a list of existing recipes
     Modify Recipe -  Modify an existing base recipe

EOS
    QuestionRouter.route question, 'menu', @record
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
    RecipeClone.check_modify_trigger modify_trigger, question
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
    QuestionRouter.route question, 'modify', @record
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
    component = RecipeModification.new @record
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
    QuestionRouter.route question, 'remove_redirect_menu', @record
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
    QuestionRouter.route question, 'yeast', @record
  end

  def primary
    question = <<EOS

Please choose a new primary yeast:
    Dupont -    Dry, spicy, mildly tart/acidic.
    French -    Dry, spicy/peppery, more prominent fruit/citrus
    American -  Trad'l saison yeast blended with Brettanomyces.

EOS
    QuestionRouter.route question, 'primary', @record
  end

  def blend
    question = <<EOS

Please choose a strain of Brettanomyces:
    Blend Brett C -  Subtle, pineapple/tropical fruit aroma
    Blend Brett B -  Moderate intensity, barnyard, musty
    Blend Brett L -  Intense Brett character, barnyard, horseblanket, dank

EOS
    QuestionRouter.route question, 'blend', @record
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
    QuestionRouter.route question, 'brett_only', @record
  end

  def brett_secondary
    question = <<EOS

Please choose a strain of Brettanomyces:
    Secondary Brett C -  Subtle, pineapple/tropical fruit aroma
    Secondary Brett B -  Moderate intensity, barnyard, musty
    Secondary Brett L -  Intense Brett character, barnyard, horseblanket, dank

EOS
    QuestionRouter.route question, 'brett_secondary', @record
  end

  def yeast_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished modifying your recipe's yeast bill?
    Yeast -   No, take me back to the Yeast modification menu.
    Modify -  Yes, take me back to the Modify Recipe menu.
    Quit -    I want to exit SaisonBuilder.

EOS
    QuestionRouter.route question, 'yeast_redirect_menu', @record
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
    QuestionRouter.route question, 'grain', @record
  end

  def sweetness
    question = <<EOS

Choose a desired sweetness character:
    Caramel -  Subtle caramel character, mild toffee
    Honey -    Subtle honey character

EOS
    QuestionRouter.route question, 'sweetness', @record
  end

  def roast
    question = <<EOS

Choose a desired roast character:
    Brown -  Less roast, more nutty, chocolate character
    Black -  More pronounced roast, light coffee notes

EOS
    QuestionRouter.route question, 'roast', @record
  end

  def brown
    puts "\nAdding dark malt character to recipe..."
    component = RecipeModification.new @record
    component.brown
  end

  def black
    puts "\nAdding dark malt character to recipe..."
    component = RecipeModification.new @record
    component.black
  end

  def wheat
    puts "\nChanging base malt composition to add wheat character..."
    component = RecipeModification.new @record
    component.wheat
  end

  def rye
    puts "\nChanging base malt composition to add rye character..."
    component = RecipeModification.new @record
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
    QuestionRouter.route question, 'grain_redirect_menu', @record
  end

  def gravity
    question = <<EOS

Would you like to increase or decrease the standard 6% gravity of your saison?
    Increase
    Decrease

EOS
    QuestionRouter.route question, 'gravity', @record
  end

  def increase
    question = <<EOS

What is your desired final gravity?
    Eight - 8% ABV
    Seven - 7% ABV

EOS
    QuestionRouter.route question, 'increase', @record
  end

  def decrease
    question = <<EOS

What is your desired final gravity?
    Five - 5% ABV
    Four - 4% ABV

EOS
    QuestionRouter.route question, 'decrease', @record
  end

  def gravity_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished modifying your recipe?
    Modify -  No, take me back to the Modify Recipe menu.
    Quit -    Yes, I want to exit SaisonBuilder.

EOS
    QuestionRouter.route question, 'gravity_redirect_menu', @record
  end

  def hops
    question = <<EOS

How would you like to change the hop character?
    Bittering -  Increase bitterness
    Flavor -     Increase flavor, some aroma
    Aroma -      Increase aroma

EOS
    QuestionRouter.route question, 'hops', @record
  end

  def flavor
    question = <<EOS
What kind of hop flavor would you like to add?
    Floral spicy -  Increase flavor/aroma (European hop character)
    Piney citrus -  Increase flavor/aroma (American hop character)

EOS
    QuestionRouter.route question, 'flavor', @record
  end

  def aroma
    question = <<EOS
What kind of hop aroma would you like to add?
    Floral -  Increase aroma (Western European)
    Spicy -   Increase aroma (Eastern European)
    Citrus -  Increase aroma (American)

EOS
    QuestionRouter.route question, 'aroma_hops', @record
  end

  def hops_redirect_menu
    question = <<EOS

Your recipe has been modified to reflect these changes.

Are you finished modifying your recipe's hops bill?
    Hops -    No, take me back to the Hops modification menu.
    Modify -  Yes, take me back to the Modify Recipe menu.
    Quit -    I want to exit SaisonBuilder.

EOS
    QuestionRouter.route question, 'hops_redirect_menu', @record
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
    QuestionRouter.route question, 'other', @record
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
    QuestionRouter.route question, 'spices', @record
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
    QuestionRouter.route question, 'spices_redirect_menu', @record
  end

  def fruit
    question = <<EOS

What fruit would like to add to the recipe?
    Peaches
    Blackberries
    Mango
    Currants

EOS
    QuestionRouter.route question, 'fruit', @record
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
    QuestionRouter.route question, 'fruit_redirect_menu', @record
  end

  def botanicals
    question = <<EOS

What botanical would you like to add to the recipe?
    Hibiscus
    Lavender
    Rose Hips

EOS
    QuestionRouter.route question, 'botanicals', @record
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
    QuestionRouter.route question, 'botanicals_redirect_menu', @record
  end

  def adjuncts
    question = <<EOS

What adjunct would you like to add to the recipe?
    Corn Sugar -       Adds to gravity without adding body or flavor.
    Turbinado Sugar -  Can contribute slight molasses character.
    Rice -             Used to lighten body/flavor.

EOS
    QuestionRouter.route question, 'adjuncts', @record
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
    QuestionRouter.route question, 'adjunct_redirect_menu', @record
  end

end






