# frozen_string_literal: true

class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item

  enum status: %i[pending packaged shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where('status = 0 OR status = 1').pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def applied_discount
    InvoiceItem
              .joins(:item)
              .joins('INNER JOIN bulk_discounts ON items.merchant_id = bulk_discounts.merchant_id AND invoice_items.quantity >= bulk_discounts.quantity_threshold')
              .where('invoice_items.id = ?', id)
              .select('invoice_items.*, bulk_discounts.*')
              .order('bulk_discounts.percent_discounted DESC')
              .pluck('bulk_discounts.id')
              .first
  end
end
