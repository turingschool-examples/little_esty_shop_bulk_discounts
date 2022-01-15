class BulkDiscount < ApplicationRecord
  validates_presence_of :markdown,
                        :quantity_threshold

  validates :markdown, numericality: { only_integer: true }                    
  validates :quantity_threshold, numericality: { only_integer: true }
  
  belongs_to :merchant
end
