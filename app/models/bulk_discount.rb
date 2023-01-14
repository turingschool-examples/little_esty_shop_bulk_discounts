class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :percentage, presence: true, numericality: { only_integer: true }
  validates :quantity_threshold, presence: true, numericality: { only_integer: true }
end