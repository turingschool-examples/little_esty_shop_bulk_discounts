class BulkDiscount < ApplicationRecord 
  validates :percentage, presence: true, numericality: true
  validates :threshold, presence: true, numericality: true
  
  belongs_to :merchant
  has_many :items, through: :merchant 
  has_many :invoices, through: :merchant
  has_many :invoice_items, through: :invoices
end