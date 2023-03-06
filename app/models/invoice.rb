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

  def invoice_items_for_merchant(merchant_id)
    merchant = Merchant.find(merchant_id)
    merchant.invoice_items.where(invoice_id: id)
  end

  def prediscount_revenue_total_for_merchant(merchant_id)
    invoice_items = invoice_items_for_merchant(merchant_id)
    invoice_items.sum(&:prediscount_revenue)
  end

  def discounted_revenue_total_for_merchant(merchant_id)
    invoice_items = invoice_items_for_merchant(merchant_id)
    invoice_items.sum(&:total_discounted_revenue)
  end

  def prediscount_revenue_total
    invoice_items.sum(&:prediscount_revenue)
    #sums all the invoice items prediscount revenue
  end
  
  def discounted_revenue_total
    invoice_items.sum(&:total_discounted_revenue)
    #sums all the invoice items revenue with discounts
  end
end
