class AddEndGameMessageToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :end_message, :string
  end
end
