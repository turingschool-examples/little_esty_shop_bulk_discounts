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

  def discount_amounts
    # invoice_items.joins(item: {merchant: :bulk_discounts}) <- this also works
    invoice_items.joins(:bulk_discounts)
    .select("invoice_items.*, MAX((invoice_items.quantity * invoice_items.unit_price) * bulk_discounts.percentage_discount) AS discount_amount")
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .group(:id)
  end
  
  def total_discount_amount
    discount_amounts.sum(&:discount_amount)
    # clue to refactor method to NOT include Ruby: <.from().sum(:discount_amount)>
  end


  def merch_total_revenue(merchant)
    invoice_items.joins(:bulk_discounts)
    .where("bulk_discounts.merchant_id = ?", merchant.id)
    .distinct
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  # def merch_discount_amounts(merchant)
  # end
end
