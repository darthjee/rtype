class CreateGameDivisions < ActiveRecord::Migration
  def change
    create_table :game_divisions do |t|
      t.integer :plannet_id

      t.timestamps null: false
    end
  end
end
