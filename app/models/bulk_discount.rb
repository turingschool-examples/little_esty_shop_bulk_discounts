class BulkDiscount < ApplicationRecord 
  validates :percentage, presence: true, numericality: true
  validates :threshold, presence: true, numericality: true
  
  belongs_to :merchant
end