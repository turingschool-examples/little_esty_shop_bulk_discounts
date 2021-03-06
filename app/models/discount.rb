class Discount < ApplicationRecord
  validates_presence_of :quantity,
                        :percentage
                        
  validates :quantity, numericality: true
  validates :percentage, numericality: true
  
  belongs_to :merchant
end