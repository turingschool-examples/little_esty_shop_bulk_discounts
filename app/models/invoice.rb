class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def discounted_total
    invoice_items.joins(item: {merchant: :bulk_discounts})
    .select("invoice_items.*, MAX((invoice_items.quantity * invoice_items.unit_price) * bulk_discounts.percentage_discount) AS discounted_total")
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .group(:id)
    .sum(&:discounted_total)
  end

end
