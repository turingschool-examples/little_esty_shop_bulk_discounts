class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates :discount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
end