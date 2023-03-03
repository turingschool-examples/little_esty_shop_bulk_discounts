class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :percent_discounted
  validates_numericality_of :percent_discounted
  validates_presence_of :quantity_threshold
  validates_numericality_of :quantity_threshold
end
