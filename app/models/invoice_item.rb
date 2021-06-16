class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  enum status: [:pending, :packaged, :shipped]
  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def find_discount
    bulk_discounts.where('threshold <= ?', quantity).order(percent: :desc).first
  end

  def total_revenue_per_invoice_item
    quantity * unit_price
  end

  def price_reduction
    (total_revenue_per_invoice_item * find_discount.percent/100).to_i
  end

  def final_price
    if find_discount.nil?
      total_revenue_per_invoice_item
    else
      total_revenue_per_invoice_item - price_reduction
    end
  end
end
