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

  # def total_item_discount(item)
  #   # require 'pry'; binding.pry
  #   discounts = BulkDiscount.where(merchant_id: item.merchant_id)  
  #   quantity = InvoiceItem.find_by(invoice_id: self.invoice_id, item_id: item.id).quantity
  #   # require 'pry'; binding.pry
    
  #   if discounts.minimum(:quantity_threshold) > quantity
  #     item.unit_price * quantity
  #   else 
  #     max_discount = (discounts.where('quantity_threshold <= ?', quantity).maximum(:markdown)) * 0.01
  #     (item.unit_price * quantity) - ((item.unit_price * quantity) * max_discount)
  #   end
  # end
end
