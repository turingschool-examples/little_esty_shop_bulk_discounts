class BulkDiscount < ApplicationRecord
  validates_presence_of :discount_percent, :quantity_threshold
  belongs_to :merchant
end