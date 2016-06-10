class CreateDefinitionUnitClasses < ActiveRecord::Migration
  def change
    create_table :definition_unit_classes do |t|
      t.string :name
      t.string :slug

      t.timestamps null: false
    end
  end
end
