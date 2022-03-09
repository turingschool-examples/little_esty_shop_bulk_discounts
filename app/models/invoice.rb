class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, 'in progress', :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def discounted_revenue
    invoice_items.joins(:bulk_discounts)
    .where('invoice_items.quantity >= bulk_discounts.threshold')
    .select('invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity * (bulk_discounts.percent / 100.0)) as total_discount')
    .group('invoice_items.id')
    .sum(&:total_discount)
  end
end
