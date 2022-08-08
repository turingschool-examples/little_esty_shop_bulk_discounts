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

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def best_discount
    bulk_discounts.order(:percentage).where("quantity <= ?", self.quantity).last
  end

  def total_revenue
    unit_price * quantity
  end

  def discount_revenue
    discount = (total_revenue * best_discount.percentage/100)
    discount.to_i
  end

  def discounted_price
    if best_discount.nil?
      total_revenue
    else
      total_revenue - discount_revenue
    end
  end

  def applied_discount
    if best_discount.present?
    best_discount.name
    end
  end
end
