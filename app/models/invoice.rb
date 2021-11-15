class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  # has_many :discounts, through: :merchants

  enum status: [:cancelled, 'in progress', :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_bulk_discount_revenue
    invoice_items.sum do |ii|
      (ii.quantity * ii.unit_price) - ((ii.quantity * ii.unit_price) * ii.discount_percentage)
    end
    # .where(transactions: {result: 0})
  end
  # def find_discount_percentage(invoice_item)
  #   discounts
  #   .joins(:invoice_items)
  #   .select('invoice_items.*')
  #   .group(:id)
  #   .where('invoice_item.quantity > discount.quantity_threshold')
  #   .order(percentage_discount: :desc)
  #   .limit(1)
  #   .pluck(:percentage_discount)
  # end
end
