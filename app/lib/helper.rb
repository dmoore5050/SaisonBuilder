module Helper

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

end