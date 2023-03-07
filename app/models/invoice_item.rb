class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status,
                        :discount

  belongs_to :invoice
  belongs_to :item

  enum status: [:pending, :packaged, :shipped]

  before_create :set_discount_id

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def total_discount
    item.merchant.bulk_discounts.where("id = ?", discount).pluck(:discount_percent).first
  end

  private

  def set_discount_id
    @discount = item.merchant.bulk_discounts.where("quantity_threshold <= ?", quantity).order(discount_percent: :desc)
    if !@discount.empty?
      self.discount = @discount.first.id
    end
  end
end
