class BulkDiscount < ApplicationRecord
  validates :percentage_discount, presence: true, numericality: true
  validates :quantity_threshold, presence: true, numericality: {only_integer: true}
  belongs_to :merchant
end