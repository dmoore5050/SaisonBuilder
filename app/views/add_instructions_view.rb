module AddInstructionsView

  def self.route_add_instructions
    puts "\nWould you like to add a Recipe or an Ingredient?"
    answer = $stdin.gets.downcase.chomp!

    case
    when answer.include?('recipe') then add_recipe_instructions_view
    when answer.include?('ingredient') then add_ingredient_instructions_view
    end

  end

  def self.add_recipe_instructions_view
    instructions = <<EOS

To add a recipe, use the following format:

sb add recipe <recipe_name>: <boil_length> <primary_fermentation_temp>

<boil_length> is the length of the boil in minutes.
Examples would include 60, 75, 90.

<primary_fermentation_temp> is the desired primary fermentation temp, followed by either F or C.
Examples: 72F, 63-78F, 74+F

Examples of valid commands:

sb add recipe midnight in bruges: 60 85F
sb add recipe francine: 90 65-72F

EOS

    puts instructions
  end

  def self.add_ingredient_instructions_view
    instructions = <<EOS

To add an ingredient, use the following format:

sb add ingredient <ingredient_name>: <ingredient_type> <white_lab_mfg_code> <wyeast_mfg_code>

The following are valid <ingredient_types>:
grain, hops, yeast, fruit, spices, botanicals, adjuncts.

White Lab and Wyeast mfg codes are used only when adding Yeast.
White Lab uses a 3 digit number, Wyeast a 4 digit number.

Examples of valid commands:

sb add ingredient red wheat malt: grain
sb add ingredient american ale: yeast 060 1056

EOS

    puts instructions
  end

end