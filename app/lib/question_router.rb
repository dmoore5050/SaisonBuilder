require_relative '../../bootstrap_ar'

module QuestionRouter

  unless const_defined?(:RECIPE_NAME_ARRAY) # gets rid of 'constant initialize' error
    RECIPE_NAME_ARRAY = %w( classic hoppy_classic rye_saison new_world black_saison pacific_6_grain)
    OPTION_ARRAY = %w( menu remove list_recipes modify yeast primary blend brett_only brett_secondary grain sweetness roast brown black wheat rye hops flavor aroma gravity increase decrease other spices fruit botanicals adjuncts more_botanicals)
    COMPONENTS_ARRAY = %w( dupont french american blend_brett_c blend_brett_b blend_brett_l only_brett_c only_brett_b only_brett_l only_brett_b_trois secondary_brett_b secondary_brett_c secondary_brett_l caramel honey wheat rye brown black eight seven five four bittering floral_spicy piney_citrus spicy floral citrus coriander citrus_zest white_peppercorns thai_basil ginger peaches blackberries mango currants hibiscus lavender rose_hips corn_sugar turbinado_sugar rice)
  end

  def self.route(question, trackback, record)
    puts question
    answer = $stdin.gets.downcase.chomp!.tr(' ', '_')

    if answer.include?('q') || answer.include?('x')
      return
    elsif answer == 'modify_recipe' || answer == 'modify' && trackback == 'menu'
      modify_trigger = 'mod' # trigger for routing, could be any string
      list_recipes modify_trigger
    elsif OPTION_ARRAY.include? answer
      next_question = QuestionView.new record
      next_question.send("#{answer}")
    elsif RECIPE_NAME_ARRAY.include? answer
      params = { recipe: { name: answer.tr('_', ' ') } }
      selected_recipe = RecipeController.new params
      selected_recipe.view
    elsif COMPONENTS_ARRAY.include? answer
      component = RecipeModification.new record
      component.send("#{answer}")
    else
      puts "\n'#{answer}' is not a valid option. Please choose from the choices listed."
      puts "Type 'Menu' to return to Recipes menu, or 'Quit' to exit SaisonBuilder."
      repeat_question = QuestionView.new record
      repeat_question.send("#{trackback}")
    end
  end
  # ****************************************** #
  #  pull below out into separate module also
  # ****************************************** #

  def self.list_recipes(modify_trigger = nil)
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

  def self.check_modify_trigger(modify_trigger, question)
    if !modify_trigger.nil?
      create_modified_recipe question
    else
      QuestionRouter.route question, 'list_recipes', @record
    end
  end

  def self.create_modified_recipe(question)
    puts question
    answer = $stdin.gets.downcase.chomp!

    if RECIPE_NAME_ARRAY.include? answer.tr(' ', '_')
      clone_recipe answer
      modify
    else
      invalid_recipe_message answer
    end
  end

  def self.clone_recipe(answer)
    puts "\nPlease give your new recipe a unique name:\n\n"
    new_name = $stdin.gets.downcase.chomp!
    puts "\nPlease enter a short description for your new recipe:\n\n"
    descr = $stdin.gets.downcase.chomp!
    base_recipe = Recipe.where(name: answer).first
    new_recipe = base_recipe.dup
    confirm_unique_name new_name, new_recipe, descr, answer
    @record = new_recipe
    new_recipe.save

    clone_recipe_ingredients base_recipe, new_recipe
  end

  def self.clone_recipe_ingredients(base_recipe, new_recipe)
    ingr_array = RecipeIngredient.where(recipe_id: base_recipe.id)
    ingr_array.each do | recipe_ingr_record |
      new_recipe_ingr = recipe_ingr_record.dup
      new_recipe_ingr[:recipe_id] = new_recipe.id
      new_recipe_ingr.save
    end
  end

  def self.confirm_unique_name(new_name, new_recipe, descr, answer)
    name_check = Recipe.where(name: new_name).first
    if name_check.nil?
      new_recipe[:name] = new_name
      new_recipe[:description] = descr
    else
      puts "#{answer} is already in use. Please choose another.\n"
      clone_recipe answer
    end
  end

  def self.invalid_recipe_message(answer)
    puts "\n'#{answer}' is not a valid option. Please choose from the recipes listed."
    puts "Type 'Menu' to return to Recipes menu, or 'Quit' to exit SaisonBuilder."
    modify_trigger = 'mod' # trigger for routing, actual string is arbitrary
    list_recipes modify_trigger
  end

  def self.modify
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
    route question, 'modify', @record
  end

end