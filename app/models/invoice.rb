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

  def find_discounted_items(merchant_id)
    invoice_items.joins(:bulk_discounts)
                 .where(merchants: {id: merchant_id})
                 .where("bulk_discounts.quantity_threshold <= invoice_items.quantity")
                 .group(:id)
                 .select("max(bulk_discounts.percent_discount) AS max_discount, invoice_items.*")
                
  end
end
