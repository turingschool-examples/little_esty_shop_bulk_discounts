class BulkDiscount < ApplicationRecord
  validates :percentage, presence: true
  validates :quantity_threshold, presence: true
  validates :merchant_id, presence: true

  belongs_to :merchant
end
