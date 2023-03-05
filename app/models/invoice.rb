class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :invoice_items

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def discounted_revenue
    all_items_with_discounts = self.invoice_items
    .select("invoice_items.*, MAX((invoice_items.quantity*invoice_items.unit_price)*(bulk_discounts.percentage_discount/100)) as individual_discount")
    .joins(:bulk_discounts)
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .group(:id)
    .sum(&:individual_discount)
 
    total_revenue - all_items_with_discounts
  end
end
