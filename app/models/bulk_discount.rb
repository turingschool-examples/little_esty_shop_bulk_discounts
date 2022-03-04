class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates :percent_discount, presence: true, numericality: {only_float: true}
  validates :qty_threshold, presence: true, numericality: {only_integer: true }
end
