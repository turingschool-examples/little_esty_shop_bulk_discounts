class BulkDiscount < ApplicationRecord
  validates_presence_of :markdown, 
                        :quantity_threshold
  
  belongs_to :merchant
end
