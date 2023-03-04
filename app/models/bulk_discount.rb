class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates :percentage_discount, inclusion: 0.1..1, presence: :true
  validates :quantity_threshold, inclusion: 1..100000, presence: :true
  validates :percentage_discount, :quantity_threshold, numericality: { only_numeric: true }

end