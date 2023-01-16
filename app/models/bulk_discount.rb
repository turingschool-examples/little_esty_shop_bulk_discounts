class BulkDiscount < ApplicationRecord
  validates :percentage_discount, presence: true, numericality: {less_than: 1, greater_than: 0}
  validates :quantity_threshold, presence: true, numericality: {only_integer: true, greater_than: 0}
  belongs_to :merchant
end