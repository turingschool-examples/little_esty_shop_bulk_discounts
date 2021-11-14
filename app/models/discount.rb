class Discount < ApplicationRecord
  validates_presence_of :percentage_discount, numericality: true
  validates_presence_of :quantity_threshold, numericality: true

  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
end
