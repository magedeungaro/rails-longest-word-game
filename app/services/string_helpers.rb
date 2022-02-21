class StringHelpers
  def self.letter_frequencies(letters)
    letters_frequencies = {}
    letters.each do |letter|
      letters_frequencies[letter] = 0 if letters_frequencies[letter].nil?
      letters_frequencies[letter] += 1
    end

    letters_frequencies
  end
end
