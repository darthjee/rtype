class AddUnitPrecision < ActiveRecord::Migration
  def change
    change_table :definition_units do |t|
      t.integer :precision
    end
  end
end
