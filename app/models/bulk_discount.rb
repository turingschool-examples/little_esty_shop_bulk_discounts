class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  # validates_presence_of :percentage, :quantity_threshold
  validates :percentage, presence: true, numericality: true
  validates :quantity_threshold, presence: true, numericality: { only_integer: true }
end