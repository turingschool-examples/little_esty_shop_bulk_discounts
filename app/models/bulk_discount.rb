class BulkDiscount < ApplicationRecord
  validates_presence_of :discount, :threshold
  validates_numericality_of :discount, allow_nil: false
  validates_numericality_of :threshold, allow_nil: false
  belongs_to :merchant
end
