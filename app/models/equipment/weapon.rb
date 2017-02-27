module Equipment
  class Weapon < ActiveRecord::Base
    self.table_name = 'equipment_weapons'
    belongs_to :character, class_name: 'Equipment::Character'

    validates :item_id, presence: true
    validates :cost, presence: true, numericality: true
  end
end
