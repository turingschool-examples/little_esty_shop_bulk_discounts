
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



  # def eligible_for_discount
  #   invoice_items
  #   .joins(:bulk_discounts)
  #   .where('invoice_items.quantity >= ?', discounts.quantity_threshold)
  #   .select(quantity * invoice_item.unit_price * (1 - percent_discount/100) as discounted_revenue)
  # end

  def find_best_discount(invoice_item)
    #return the total and the bulk_id
    eligible_for_discount

    .where('invoice_items.id = ?', invoice_item.id)
    .order('discounted_revenue')
    .limit(1)
  end
  #
  # def price_with_discount(discount_id)
  #
  #
  # end
  #
  # def total_revenue
  #   invoice_items.sum do |item|
  #     item.find_best_discount(item).discounted_revenue
  #   end
  # end
  #invoice.items.joins(merchant: :discounts)


end
