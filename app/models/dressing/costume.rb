module Dressing
  class Costume < ActiveRecord::Base
    self.table_name = 'dressing_costumes'
    belongs_to :avatar

    validates :item_id, presence: true
  end
end
