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

  # def total_merch_revenue
  # end

  def total_discount_amount #(merch_id)
    x = invoice_items.joins(:bulk_discounts)
    .select("invoice_items.*, MAX((invoice_items.quantity * invoice_items.unit_price) * bulk_discounts.percentage_discount) AS discount_amount")
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .group(:id)
    
    x.sum(&:discount_amount)
  end
end
