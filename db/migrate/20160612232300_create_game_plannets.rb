class CreateGamePlannets < ActiveRecord::Migration
  def change
    create_table :game_plannets do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
