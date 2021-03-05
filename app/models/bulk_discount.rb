class BulkDiscount < ApplicationRecord
  validates_presence_of :name,
                        :percentage_discount,
                        :quantity_threshold,
                        :merchant_id

  belongs_to :merchant
end
