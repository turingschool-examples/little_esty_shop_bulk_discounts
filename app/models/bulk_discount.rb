class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :percent
  validates_presence_of :threshold
  validates_presence_of :merchant_id
end
