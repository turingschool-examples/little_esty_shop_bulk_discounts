class BulkDiscount < ApplicationRecord
  validates_presence_of :percent_discount, :quantity_threshold
  belongs_to :merchant
end