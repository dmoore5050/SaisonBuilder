module ControllerHelper

  def titleize
    self.split(' ').map { |word| word.capitalize }.join(' ')
  end

  def self.creation_success_message(record)
    case
    when record.save then puts "\nSuccess!"
    else puts "Failure: #{record.errors.full_messages.join(", ")}"
    end
  end

  def self.matching_record_destroyed_message(match)
    case
    when match.destroyed?
      puts "\nThe record has been deleted."
    else puts "Failure: #{match.errors.full_messages.join(", ")}"
    end
  end

  def self.confirm_match(record)
    if record.nil?
      puts "\nThat is not a valid record name."
      puts 'Type sb ingredients to view a list of ingredients, or'
      puts 'type sb list to view a list of recipes.'
      exit
    end
  end

end