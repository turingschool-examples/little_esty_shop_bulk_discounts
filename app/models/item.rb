class Item < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :merchant_id

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  enum status: [:disabled, :enabled]

  def best_day
    invoices
    .joins(:invoice_items)
    .where('invoices.status = 2')
    .select('invoices.*, sum(invoice_items.unit_price * invoice_items.quantity) as money')
    .group(:id)
    .order("money desc", "created_at desc")
    .first&.created_at&.to_date
  end

  def total_item_discount(item, invoice)
    discounts = BulkDiscount.where(merchant_id: item.merchant_id)  
    quantity = InvoiceItem.find_by(invoice_id: invoice.id, item_id: item.id).quantity
    
    if discounts.minimum(:quantity_threshold) > quantity
      item.unit_price * quantity
    else 
      max_discount = (discounts.where('quantity_threshold <= ?', quantity).maximum(:markdown)) * 0.01
      (item.unit_price * quantity) - ((item.unit_price * quantity) * max_discount)
    end
  end
end
