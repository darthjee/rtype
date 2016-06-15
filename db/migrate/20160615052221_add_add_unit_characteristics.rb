class AddAddUnitCharacteristics < ActiveRecord::Migration
  def change
    change_table :definition_units do |t|
      t.integer :life
      t.integer :armor
      t.integer :dexterity
      t.integer :initiative
      t.integer :attacks
      t.integer :power
    end
  end
end
