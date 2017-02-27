class CreateEquipmentWeapons < ActiveRecord::Migration
  def change
    create_table :equipment_weapons do |t|
      t.belongs_to :equipment_character, index: true
      t.integer :item_id
      t.integer :cost

      t.timestamps null: false
    end
  end
end
