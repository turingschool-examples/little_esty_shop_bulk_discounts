class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :name, presence: true
  validates :percentage_discount, presence: true
  validates :quantity_threshold, presence: true
end