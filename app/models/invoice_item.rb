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

  def revenue_no_discount_applied
    (quantity * unit_price)
  end
  
  def revenue_with_discount_applied
    if discount_applied.nil?
      revenue_no_discount_applied
    else
      revenue_no_discount_applied - total_discount
    end
  end

  def discount_applied
    bulk_discounts
    .where("bulk_discounts.quantity_threshold <= ?", quantity)
    .order(percentage_discount: :desc)
    .first
  end

  def total_discount
    (discount_applied.percentage_discount.to_f/100 * revenue_no_discount_applied)
  end
end
