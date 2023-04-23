class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_discounted_amount
    invoice_items
    .joins(item: { merchant: :bulk_discounts })
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .select("invoice_items.*, MAX(invoice_items.quantity * invoice_items.unit_price * (bulk_discounts.percentage_discount / 100)) AS total_discount")
    .group(:id)
    .sum { |invoice_item| invoice_item.total_discount }
  end

  def total_revenue_after_discount
    total_revenue - total_discounted_amount
  end
end
