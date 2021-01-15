class BulkDiscount < ApplicationRecord
  validates_presence_of :name,
                        :discount,
                        :threshold,
                        :merchant

  belongs_to :merchant
end
