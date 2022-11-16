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

  def discount_total
    invoice_items.joins(merchants: :bulk_discounts)
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .select('invoice_items.id, max(invoice_items.quantity * invoice_items.unit_price * (bulk_discounts.percentage / 100.0)) as total_discount')
    .group('invoice_items.id')
    .sum(&:total_discount)
  end

  def revenue_with_discount 
    total_revenue - discount_total
  end
end
