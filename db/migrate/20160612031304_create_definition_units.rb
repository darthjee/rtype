class CreateDefinitionUnits < ActiveRecord::Migration
  def change
    create_table :definition_units do |t|
      t.string :name
      t.string :slug
      t.integer :race_id
      t.integer :unit_class_id

      t.timestamps null: false
    end
  end
end
