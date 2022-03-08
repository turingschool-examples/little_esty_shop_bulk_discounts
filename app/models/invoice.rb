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

  def discount
    invoice_items.joins(:bulk_discounts)
      .select("invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity * (bulk_discounts.percent_discount / 100.00)) as total_discount")
      .where("invoice_items.quantity >= bulk_discounts.qty_threshold")
      .group("invoice_items.id")
      .sum(&:"total_discount")
  end

  def discounted_total_revenue
    total_revenue - discount
  end

  def items_by_merchant(merch_id)
    items.where('merchant_id = ?', merch_id)
  end

  def total_revenue_by_merchant(merch_id)
    items_by_merchant(merch_id).sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def discounts_by_merchant(merch_id)
    invoice_items.joins(:bulk_discounts)
      .select("invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity * (bulk_discounts.percent_discount / 100.00)) as total_discount")
      .where("invoice_items.quantity >= bulk_discounts.qty_threshold")
      .where("bulk_discounts.merchant_id = ?", merch_id)
      .group("invoice_items.id")
      .order("total_discount desc")
      .sum(&:"total_discount")
  end

  def discounted_revenue_by_merchant(merch_id)
    total_revenue_by_merchant(merch_id) - discounts_by_merchant(merch_id)
  end
end
