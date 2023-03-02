class BulkDiscount < ApplicationRecord
  validates_presence_of :percentage_discount, :quantity_threshold
  validates :percentage_discount, numericality: { greater_than: 0, less_than: 100}
  validates :quantity_threshold, numericality: { greater_than: 0 }

  belongs_to :merchant

  enum status: [:enabled, :disabled]
end