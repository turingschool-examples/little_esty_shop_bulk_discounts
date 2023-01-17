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

  def find_discount
    item.merchant.bulk_discounts
        .where('quantity_threshold <= ?', quantity)
        .order(percentage: :desc).first
  end

  def revenue
    (quantity * unit_price)
  end

  def discount_unit_price
    if find_discount.nil?
      revenue 
    else
      revenue * (1 - find_discount.percentage.fdiv(100))
    end
  end
end
