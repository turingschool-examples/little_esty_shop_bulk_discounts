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

  def total_item_discount
    discounts = BulkDiscount.where(merchant_id: (Item.find(self.item_id).merchant_id))
    invoice = Invoice.find(self.invoice_id)
    max_discount = (discounts.where('quantity_threshold <= ?', self.quantity).maximum(:markdown)) 

    if max_discount != nil
      (invoice.total_revenue) - ((invoice.total_revenue * max_discount) * 0.01)
    else 
      invoice.total_revenue
    end
  end
end
