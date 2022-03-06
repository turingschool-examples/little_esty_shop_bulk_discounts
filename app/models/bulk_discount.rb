class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :merchant

  validates :percent_discount, presence: true, numericality: {only_integer: true}
  validates :qty_threshold, presence: true, numericality: {only_integer: true }
end
