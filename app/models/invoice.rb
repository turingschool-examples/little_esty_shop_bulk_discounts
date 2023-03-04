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
  
  # Select the invoiceitems where quantity is greater than threshold
  # Mulitply total_revenue by discount percentage as a float(5% -> .05)
  # Subtract the difference from total revenue
  def discounted_revenue
  end
end
