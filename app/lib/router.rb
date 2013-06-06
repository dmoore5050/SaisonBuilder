require_relative '../../bootstrap_ar'

module Router

  def self.route(question_string, trackback, record)
    puts question_string
    answer = $stdin.gets.downcase.chomp!.tr(' ', '_')
    question = QuestionView.new record

    if answer.include?('q') || answer.include?('x')
      return
    elsif OPTION_ARRAY.include? answer
      question.send("#{answer}")
    else
      puts "\n'#{answer}' is not a valid option. Please choose from the choices listed."
      puts "Type 'Menu' to return to Recipes menu, or 'Quit' to exit SaisonBuilder."
      question.send("#{trackback}")
    end
  end

end