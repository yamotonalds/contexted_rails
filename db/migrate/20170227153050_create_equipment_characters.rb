class CreateEquipmentCharacters < ActiveRecord::Migration
  def change
    create_table :equipment_characters do |t|
      t.belongs_to :character, index: true

      t.timestamps null: false
    end
  end
end
