class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def discounted_revenue
    total_discount = invoice_items.joins(item: { merchant: :bulk_discounts }, invoice: :customer)
      .where('invoice_items.quantity >= bulk_discounts.quantity')
      .select('SUM(invoice_items.quantity * invoice_items.unit_price * bulk_discounts.discount / 100) AS total_discount')
      .group('invoices.id')
      .sum(&:total_discount)
    total_revenue - total_discount
  end
end
