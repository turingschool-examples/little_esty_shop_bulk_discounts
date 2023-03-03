class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates :discount, presence: true
  validates :quantity, presence: true, numericality: true
end