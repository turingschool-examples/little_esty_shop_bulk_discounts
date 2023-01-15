class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item
  has_many :discounts, through: :merchants

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def self.qualifying_invoice_items 
    joins(merchants: [:items, :invoice_items])
    # .select('discounts.*')
    .where('invoice_items.quantity >= ?', threshold)
  end

  # def total_price
  #   quantity * unit_price
  # end

  # def discounted_total_price(discount)
  #   if quantity >= discount.threshold
  #     # discounted_unit_price = unit_price * ((100.0 - discount.percentage)/100)
  #     # discounted_unit_price * quantity
  #     total_price * ((100.0 - discount.percentage)/100)
  #   else 
  #     total_price
  #   end
  # end

  def apply_discount(percentage)
    discounted_unit_price = unit_price * ((100.0 - percentage)/100)
    update(unit_price: discounted_unit_price )
  end
end
