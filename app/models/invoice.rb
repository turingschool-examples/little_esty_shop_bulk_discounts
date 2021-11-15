class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants

  enum status: [:cancelled, 'in progress', :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def find_discount_percentages
    wip = discounts.joins(:invoice_items)
    .where()
    .order(percentage_discount: :desc)
    .distinct
    .pluck(:percentage_discount)
    require "pry"; binding.pry
  end
end
