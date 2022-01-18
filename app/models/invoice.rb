class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  enum status: [:cancelled, 'in progress', :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def discounted_revenue
    total_discount =  merchants
                              .joins(:bulk_discounts)
                              .where('invoice_items.quantity >= bulk_discounts.threshold')
                              .select('invoice_items.*')
                              .group('invoice_items.item_id')
                              .maximum('invoice_items.quantity * invoice_items.unit_price * bulk_discounts.percentage / 100')
                              .pluck(1)
                              .sum

    if total_discount == 0
      return 'No Discount Applied'
    else
      return total_revenue - total_discount
    end
  end
end
