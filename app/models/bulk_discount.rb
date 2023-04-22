class BulkDiscount < ApplicationRecord
  validates_presence_of :percentage_discount, :quantity_threshold, :promo_name
  validates_numericality_of :percentage_discount, greater_than: 0, less_than: 1.00
  validates_numericality_of :quantity_threshold, greater_than: 0
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
end