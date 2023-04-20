class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :percentage_discount
  validates_presence_of :quantity_threshold
end
