class CreateGameBattleEvents < ActiveRecord::Migration
  def change
    create_table :game_battle_events do |t|

      t.timestamps null: false
    end
  end
end
