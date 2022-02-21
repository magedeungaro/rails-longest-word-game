class PagesController < ApplicationController
  def play
    @letters = generate_grid(rand(5..10))
  end

  def score
    grid = params[:grid].split(' ')
    start_time = Time.new(params[:start_time])
    end_time = Time.now
    @guess = params[:longest_word]
    @result = run_game(@guess, grid, start_time, end_time)
  end

  private

  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    letters = ('A'..'Z').to_a
    grid = Array.new(grid_size)

    grid.map { letters.sample }
  end

  def run_game(attempt, grid, start_time, end_time)
    # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
    time_elapsed = end_time - start_time
    result = { score: 0, message: 'Congratulations!', time: time_elapsed }
    attempt.upcase!
    valid = valid?(attempt, grid)
    english = english?(attempt)

    result[:message] = 'Your guess is not a valid word' unless valid
    result[:message] = 'Your guess is not an english word' unless english
    result[:score] = result(attempt, time_elapsed) if valid && english
    result
  end

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.open(url).read
    word_verify = JSON.parse(word_serialized)

    word_verify['found']
  end

  def in_grid?(word, grid)
    on_grid = true
    word.chars.each { |char| on_grid = false unless grid.include?(char) }

    on_grid
  end

  def letter_frequencies(letters)
    letters_frequencies = {}
    letters.each do |letter|
      letters_frequencies[letter] = 0 if letters_frequencies[letter].nil?
      letters_frequencies[letter] += 1
    end

    letters_frequencies
  end

  def overused?(word, grid)
    grid_frequencies = letter_frequencies(grid)
    word_frequencies = letter_frequencies(word.chars)

    overused = false
    word_frequencies.each { |key, value| overused = true if value > grid_frequencies[key] }

    overused
  end

  def valid?(word, grid)
    in_grid?(word, grid) && !overused?(word, grid)
  end

  def result(word, time_elapsed)
    ((word.length * 1_000) - (time_elapsed.to_i / 60_000))
  end
end
