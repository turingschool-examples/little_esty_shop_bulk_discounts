class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status
  belongs_to :invoice
  belongs_to :item
  has_many :discounts
  has_many :discounts, through: :item



  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def self.eligible_items
    joins(:item)
    .where('items.id = invoice_items.item_id')
    .joins(:discounts)
    .where('invoice_items.quantity >= discounts.quantity_threshold')
  end
end

    # def self.discounted_price
    #   joins(:item)
    #   .where('items.id = invoice_items.item_id')
    #   .joins(:discounts)
    #   .where('invoice_items.quantity >= discounts.quantity_threshold')
    # end
