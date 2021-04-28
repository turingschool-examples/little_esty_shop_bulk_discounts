class BulkDiscount < ApplicationRecord
  validates :name, presence: true, exclusion: { in: %w(Kyle kyle), message: "Nice, try. Don't put this on Kyle! He doesn't even work here!" }
  validates :percentage_discount, numericality: true, inclusion: { in: ( 1..99 ), message: "Please enter a number 1-99" }
  validates :quantity_threshold, numericality: { greater_than: 0 }
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
end
