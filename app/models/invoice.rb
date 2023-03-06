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
  #this is for US 8..
  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end
  #this is for US 8...
  def discounted_revenue
    total_discount = invoice_items.joins(:bulk_discounts)
    .select('invoice_items.*, MAX((invoice_items.quantity * invoice_items.unit_price) * bulk_discounts.percentage_discount) AS total_discount')
    .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
    .group(:id)
    .sum(&:total_discount)
    total_revenue - total_discount
  end
end
