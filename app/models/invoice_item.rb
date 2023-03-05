class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item
  has_many :bulk_discounts, through: :item

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def applied_bd_title
    bulk_discounts.where("bulk_discounts.quantity_threshold <= ?", self.quantity).order(percentage_discount: :desc).first
    # .select("bulk_discounts.title").where("MAX((invoice_items.quantity * invoice_items.unit_price) * bulk_discounts.percentage_discount) AS discount_amount").where("invoice_items.quantity >= bulk_discounts.quantity_threshold").group(:id)
  end
end
