class CreateGameSquadrons < ActiveRecord::Migration
  def change
    create_table :game_squadrons do |t|
      t.integer :division_id
      t.integer :unit_id
      t.integer :quantity
      t.integer :damage, default: 0

      t.timestamps null: false
    end
  end
end
