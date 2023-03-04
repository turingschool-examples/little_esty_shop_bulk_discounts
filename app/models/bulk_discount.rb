class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :quantity_threshold, numericality: { only_integer: true, greater_than: 0, only_integer: true }
  validates :percent_discounted, numericality: { only_integer: true, greater_than: 0, less_than: 101, only_integer: true } 
end
