class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant
# ^ may not be necessary - use method instead
  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def best_discount
    bulk_discounts.best_discount(self)
  end

  def revenue
    if best_discount
      discount_amount = best_discount.discount * unit_price
      discounted_price = unit_price - discount_amount
      discounted_price * quantity
    else
      unit_price * quantity
    end
  end
end
