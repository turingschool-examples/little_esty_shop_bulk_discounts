class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  # Both work...but why did they do this: 
  enum status: [:cancelled, 'in progress', :completed]
  # enum status: [:cancelled, :in_progress, :completed]


  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_discount_amount
    require 'pry'; binding.pry
    invoice_items.joins(:bulk_discounts)
    invoice_items.joins(:bulk_discounts).where("invoice_items.quantity >= bulk_discounts.quantity_threshold") 
  end

  # (invoice.total_revenue - invoice.discounted_revenue) or in controller? 

  # def total_discount_revenue
  #   SUM(discount_amount) - total_revenue ??
  # end
end
