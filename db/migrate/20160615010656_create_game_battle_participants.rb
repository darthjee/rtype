class CreateGameBattleParticipants < ActiveRecord::Migration
  def change
    create_table :game_battle_participants do |t|
      t.integer :event_id
      t.integer :division_id
      t.string :role

      t.timestamps null: false
    end
  end
end
