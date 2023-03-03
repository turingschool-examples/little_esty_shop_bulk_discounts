class BulkDiscount < ApplicationRecord
  validates_presence_of :percentage_discount, :quantity_threshold
  validates :percentage_discount, numericality: { greater_than: 0, less_than: 100}
  validates :quantity_threshold, numericality: { greater_than: 0 }

  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  
  enum status: [:inactive, :active]
end