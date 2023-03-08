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
  
  def merchant_total_revenue(merchant)
   self.invoice_items.joins(:item)
    .where(items: {merchant_id: merchant.id})
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def discount
    all_ii_discounts = self.invoice_items.joins(:bulk_discounts)
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshhold")
    .select("invoice_items.*, MAX( invoice_items.quantity * invoice_items.unit_price* bulk_discounts.percentage ) as max_discount")
    .group(:id)
   
    InvoiceItem.from(all_ii_discounts).sum("max_discount")
  end

  def discounted_revenue(merchant)
    merchant_total_revenue(merchant) - discount
  end
end
