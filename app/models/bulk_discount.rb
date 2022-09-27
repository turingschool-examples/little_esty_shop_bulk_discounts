class BulkDiscount < ApplicationRecord
  validates_presence_of :threshold
  validates_presence_of :discount_percent
  
  belongs_to :merchant
end
