module Helper

  def titleize
    self.split(' ').map { |word| word.capitalize }.join(' ')
  end

end