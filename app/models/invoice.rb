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

  def total_revenue_with_discounts(merchant) 

    if has_discount?(merchant)
      discounted_transactions = invoice_items
      .joins(:bulk_discounts)
      .where("invoice_items.quantity > bulk_discounts.threshold AND merchants.id = ?", merchant.id)
      .group('invoice_items.id')
      .sum('((invoice_items.quantity * invoice_items.unit_price) / 100) * (100 - bulk_discounts.percentage)')
      .values
      .sum 

      regular_transactions = invoice_items
      .joins(:bulk_discounts)
      .where("invoice_items.quantity <= bulk_discounts.threshold AND merchants.id = ?", merchant.id)
      .group('invoice_items.id')
      .sum('invoice_items.quantity * invoice_items.unit_price')
      .values
      .sum

      return discounted_transactions + regular_transactions
    else 
      regular_transactions = invoice_items
      .joins(:merchants)
      .where("merchants.id = ?", merchant.id)
      .group('invoice_items.id')
      .sum('invoice_items.quantity * invoice_items.unit_price')
      .values
      .sum 

      return regular_transactions
    end 
  end

private 
  def has_discount?(merchant)
    BulkDiscount.where(merchant_id: merchant.id).count > 0
  end
end
