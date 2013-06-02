require_relative '../../bootstrap_ar'

module RecipeClone

  def self.create_modified_recipe(question)
    puts question
    answer = $stdin.gets.downcase.chomp!

    if RECIPE_NAME_ARRAY.include? answer.tr(' ', '_')
      clone_recipe answer
      modify_choice = QuestionView.new @record
      modify_choice.menu
    else
      invalid_recipe_message question, answer
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

  def self.invalid_recipe_message(question, answer)
    puts "\n'#{answer}' is not a valid option. Please choose from the recipes listed."
    puts "Type 'Menu' to return to Recipes menu, or 'Quit' to exit SaisonBuilder."
    create_modified_recipe question
  end

end