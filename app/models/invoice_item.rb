class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def discount
    item.merchant.discounts.where('threshold <= ?', quantity).order(:percentage).last
  end

  def total_discount_revenue
    if discount.present?
      (invoice.total_revenue * (1 - (discount.percentage / 100.00))).round(2)
    else
      invoice.total_revenue
    end 
  end
end
