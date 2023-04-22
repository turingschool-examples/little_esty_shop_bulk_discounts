class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :name, presence: true
  validates :discount_percent, presence: true
  validates :quantity_threshold, presence: true
end
