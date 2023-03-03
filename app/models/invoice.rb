class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  # def discounted_revenue
  #  require 'pry'; binding.pry
  # end

  def discounted_items(merchant_id)
    invoice_items.joins(:bulk_discounts)
    .where(merchants: {id: merchant_id})
    .where("invoice_items.quantity >= bulk_discounts.threshold")
    .group(:id)
    .select("max(bulk_discounts.percentage) as max_discount, invoice_items.*")
  end
end
