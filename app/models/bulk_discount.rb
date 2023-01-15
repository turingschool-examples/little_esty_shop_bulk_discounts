class BulkDiscount < ApplicationRecord
  validates_presence_of :percent_discount, :quantity_threshold
  validates :percent_discount, numericality: { only_integer: true }
  validates :quantity_threshold, numericality: { only_integer: true }
  belongs_to :merchant
end