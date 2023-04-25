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

  def non_discounted_items(merchant_id)
    invoice_items.joins(:bulk_discounts)
                 .where(merchants: {id: merchant_id})
                 .group(:id)
                 .having("invoice_items.quantity < min(bulk_discounts.quantity_threshold)")
  end

  def discounted_revenue(merchant_id)
    find_discounted_items(merchant_id).sum do |ii|
      ii.quantity * (ii.unit_price - (ii.unit_price * ii.max_discount / 100)) 
    end
  end

  def non_discounted_revenue(merchant_id)
     non_discounted_items(merchant_id).sum do |ii|
      ii.quantity * ii.unit_price 
    end
  end

  def total_discounted_rev(merchant_id)
   discounted_revenue(merchant_id) + non_discounted_revenue(merchant_id)
  end
end
