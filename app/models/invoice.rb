class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, 'in progress', :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def self.applied_discount(invoice_item)
    applied_discount = 1
    BulkDiscount.order(discount: :asc).each do |discount|

      if invoice_item.quantity >= discount.quantity
        applied_discount = discount.discount
      end
    end
    ((1 - applied_discount) * (invoice_item.unit_price * invoice_item.quantity)).round(2)

  end
end
