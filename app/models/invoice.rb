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

  def discount_amount
    invoice_items.joins(:discounts)
    .where("invoice_items.quantity >= discounts.quantity")
    .select("((invoice_items.quantity * invoice_items.unit_price) * (discounts.percentage/100)) AS discount, invoice_items.*, discounts.id AS discount_id")
    .order("discounts.percentage desc")
  end

  def new_total
    total_revenue - discount_amount.uniq.sum(&:discount)
  end

  def display_discount(invoice_item_id)
    return "No Discount" if discount_amount.where("invoice_items.id = ?", invoice_item_id).empty?
    discount_amount.where("invoice_items.id = ?", invoice_item_id).first.discount_id
  end
  
end
