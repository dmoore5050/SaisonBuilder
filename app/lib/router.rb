require_relative '../../bootstrap_ar'

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