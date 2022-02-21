class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.jsonb :grid
      t.string :attempt
      t.integer :score
      t.timestamp :start_time
      t.timestamp :end_time
      t.integer :elapsed_time

      t.timestamps
    end
  end
end
