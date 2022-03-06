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

  def total_revenue_by_merchant(merch_id)
    items.where('merchant_id = ?', merch_id)
         .sum("invoice_items.unit_price * invoice_items.quantity")  
  end
end
