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

  def all_item_discount_savings
    self
    .invoice_items
    .joins(:bulk_discounts)
    .select('invoice_items.id, (max(invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percentage_discount)) as max_savings, max(bulk_discounts.percentage_discount) as max_discount')
    .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
    .group(:id)
  end

  def total_savings
    all_item_discount_savings.sum(&:max_savings)
  end

  def total_discounted_revenue
    total_revenue - total_savings
  end
end
