class BulkDiscount < ApplicationRecord
  validates :percent_discount, 
            :quantity_threshold, 
             numericality: true,
             presence: true

  belongs_to :merchant
end
