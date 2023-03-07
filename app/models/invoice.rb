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

  def invoice_discounted_amount
    invoice_items.joins(item: {merchant: :bulk_discounts})
    .select("invoice_items.*, MAX((invoice_items.quantity * invoice_items.unit_price) * bulk_discounts.percentage_discount) AS discounted_total")
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .group(:id)
    .sum(&:discounted_total) 
  end

  def total_revenue_for(merchant)
    invoice_items.joins(item: :merchant)
    .where(item_id: merchant.items.ids)
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def discounted_amount_for(merchant)
    invoice_items.joins(item: {merchant: :bulk_discounts})
    .select("invoice_items.*, MAX((invoice_items.quantity * invoice_items.unit_price) * bulk_discounts.percentage_discount) AS discounted_total")
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .where(item_id: merchant.items.ids)
    .group(:id)
    .sum(&:discounted_total)
  end

  def total_discounted_revenue(merchant)
    
  end
end
