class CreateDefinitionRaces < ActiveRecord::Migration
  def change
    create_table :definition_races do |t|
      t.string :name
      t.string :slug

      t.timestamps null: false
    end
  end
end
