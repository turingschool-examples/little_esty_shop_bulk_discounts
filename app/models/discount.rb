class Discount < ApplicationRecord
  validates_presence_of :quantity,
                        :percentage
                        
  validates :quantity, numericality: true
  validates :percentage, numericality: true
  
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
end