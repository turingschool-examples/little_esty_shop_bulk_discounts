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
  # Can't join 'InvoiceItem' to association named 'bulk_discounts'
  # def discount_revenue
  #   invoice_items.joins(:bulk_discounts)
  #   .select('invoice_items.id, MAX((invoice_items.quantity) * invoice_items.unit_price * percentage / 100) as discount_amt')
  #   .where('invoice_items.id = #{invoice_items.id} AND invoice.item.quantity >= bulk_discounts.quantity_threshold')
  #   .group('invoice_items.id')
  #   .sum(&:discount_amt)
  # end

  # def total_discount_revenue
  #   (total_revenue - discount_revenue)
  # end
end
