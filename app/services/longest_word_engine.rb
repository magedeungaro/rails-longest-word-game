class LongestWordEngine
  def initialize(game)
    # game instance
    @game = game
    @grid = game.grid
  end

  def run_game(attempt)
    # setting attempt
    @game.attempt = attempt.upcase

    # setting end_time
    @game.end_time = Time.now

    # setting time_elapsed
    @game.elapsed_time = (@game.end_time - @game.start_time).to_i
    score = 0
    message = 'Congratulations!'

    valid = valid?
    english = english?

    message = 'Your guess is not a valid word' unless valid
    message = 'Your guess is not an english word' unless english
    score = result if valid && english

    @game.score = score
    @game.end_message = message

    @game.save
  end

  private

  def english?
    url = "https://wagon-dictionary.herokuapp.com/#{@game.attempt}"
    word_serialized = URI.open(url).read
    word_verify = JSON.parse(word_serialized)

    word_verify['found']
  end

  def in_grid?
    in_grid = true
    @game.attempt.chars.each { |char| in_grid = false unless @grid.include?(char) }

    in_grid
  end

  def overused?
    grid_frequencies = StringHelpers.letter_frequencies(@grid)
    word_frequencies = StringHelpers.letter_frequencies(@game.attempt.chars)

    overused = false
    word_frequencies.each { |key, value| overused = true if value > grid_frequencies[key] }

    overused
  end

  def valid?
    in_grid? && !overused?
  end

  def result
    ((@game.attempt.length * 1_000) - (@game.elapsed_time / 60_000))
  end
end
