class PagesController < ApplicationController
  def play
    @new_game = Game.new
    @new_game.save
  end

  def score
    @game = Game.find(params[:game_id].to_i)
    engine = LongestWordEngine.new(@game)
    engine.run_game(params[:attempt])
  end
end
