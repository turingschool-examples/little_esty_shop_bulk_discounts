class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_revenue_with_discounts
    # item needs to belong to merchnat with discount
    # discounts need to be organized % descending
    
    bulk_discount.order("")
  end
end
