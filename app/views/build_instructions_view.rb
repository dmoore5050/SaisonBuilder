module BuildInstructionsView

  def self.build_recipe_instructions_view
    instructions = <<EOS

To add a recipe, use the following format:

ruby sb add recipe <recipe_name>: <boil_length> <primary_fermentation_temp>

<boil_length> is the length of the boil in minutes.
Examples would include 60, 75, 90.

<primary_fermentation_temp> is the desired primary fermentation temp, followed by either F or C.
Examples: 72F, 63-78F, 74+F

Examples of valid commands:

ruby sb build midnight in bruges: 60 85F
ruby sb build francine: 90 65-72F

EOS

    puts instructions
  end

end