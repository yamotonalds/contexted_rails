class CreateDressingCostumes < ActiveRecord::Migration
  def change
    create_table :dressing_costumes do |t|
      t.belongs_to :avatar, index: true
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
