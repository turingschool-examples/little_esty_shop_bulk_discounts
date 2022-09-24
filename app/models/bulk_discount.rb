class BulkDiscount < ApplicationRecord
  validates_presence_of :percent_off
  validates_presence_of :quantity
  validates_numericality_of :quantity
  validate :status
  validates_presence_of :merchant_id

  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  enum status: { 'disabled' => 0, 'enabled' => 1 }
end
