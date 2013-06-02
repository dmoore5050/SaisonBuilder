require_relative '../../bootstrap_ar'

RECIPE_NAME_ARRAY = %w( classic hoppy_classic rye_saison new_world black_saison pacific_6_grain)
OPTION_ARRAY = %w( menu remove modify yeast primary blend brett_only brett_secondary grain sweetness roast brown black wheat rye hops flavor aroma gravity increase decrease other spices fruit botanicals adjuncts more_botanicals)
COMPONENTS_ARRAY = %w( dupont french american blend_brett_c blend_brett_b blend_brett_l only_brett_c only_brett_b only_brett_l only_brett_b_trois secondary_brett_b secondary_brett_c secondary_brett_l caramel honey wheat rye brown black eight seven five four bittering floral_spicy piney_citrus spicy floral citrus coriander citrus_zest white_peppercorns thai_basil ginger peaches blackberries mango currants hibiscus lavender rose_hips corn_sugar turbinado_sugar rice)

module Router

  def self.route(question, trackback, record)
    puts question
    answer = $stdin.gets.downcase.chomp!.tr(' ', '_')

    if answer.include?('q') || answer.include?('x')
      return
    elsif OPTION_ARRAY.include? answer
      next_question = QuestionView.new record
      next_question.send("#{answer}")
    elsif COMPONENTS_ARRAY.include? answer
      component = RecordModification.new record
      component.send("#{answer}")
    else
      puts "\n'#{answer}' is not a valid option. Please choose from the choices listed."
      puts "Type 'Menu' to return to Recipes menu, or 'Quit' to exit SaisonBuilder."
      repeat_question = QuestionView.new record
      repeat_question.send("#{trackback}")
    end
  end

end