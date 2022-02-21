class Game < ApplicationRecord
  before_create do
    self.grid = generate_grid(rand(5..15))
    self.start_time = Time.now
  end

  private

  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    letters = ('A'..'Z').to_a
    grid = Array.new(grid_size)

    grid.map { letters.sample }
  end
end
