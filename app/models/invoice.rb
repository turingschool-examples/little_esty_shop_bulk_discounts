
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
    # require "pry"; binding.pry
  end

  def discounted_revenue
    # require "pry"; binding.pry
    total_revenue - total_savings
  end

  def total_savings
    total_savings_relation.sum do |num|
      num.max
      # require "pry"; binding.pry
    end
  end

  def total_savings_relation
    items
    .joins(merchant: :bulk_discounts)
    .select("invoice_items.item_id, MAX(invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percentage_discount)")
    .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
    .group("invoice_items.item_id")
  end

  # def total_revenue_other
  #   items.joins(merchant: :bulk_discounts)
  #   .select("invoice_items.item_id, MAX(invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percent_discount)")
  #   .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
  #   .group("invoice_items.item_id")
  # end

end
