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

  # First attempt: doesn't work: 
  # def merch_total_revenue(merchant)
  #   invoice_items.joins(:merchants)
  #   .where("merchants.id = ?", merchant.id)
  #   .sum("invoice_items.unit_price * invoice_items.quantity")
  # end

  def merch_total_revenue(merchant)
    invoice_items.joins(:bulk_discounts)
    .where("bulk_discounts.merchant_id = ?", merchant.id)
    .distinct
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def discount_amounts 
    x = invoice_items.joins(:bulk_discounts)
    .select("invoice_items.*, MAX((invoice_items.quantity * invoice_items.unit_price) * bulk_discounts.percentage_discount) AS discount_amount")
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .group(:id)
  end

  def total_discount_amount
    discount_amounts.sum(&:discount_amount)
    # clue to refactor method to NOT include Ruby: <.from().sum(:discount_amount)>
  end

  def title(inovice_item)
    total_discount_amount.find(&:title)
  end
end
