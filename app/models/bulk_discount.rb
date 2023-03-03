class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :name,
                        :percentage_discount,
                        :quantity_threshold
end
