class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item
  has_many :discounts, through: :merchant

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def find_discount
    item.merchant.discounts.where('? >= discounts.threshold', quantity)
                           .select('discounts.*')
                           .order(percentage: :desc)
                           .first
  end

  def pre_discount_revenue
    unit_price * quantity
  end

  def discounted_revenue
    if find_discount.present?
      pre_discount_revenue - (pre_discount_revenue * (find_discount.percentage.to_f * 0.01))
    else
      pre_discount_revenue
    end
  end
end
