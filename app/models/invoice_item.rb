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

  def self.discounted_prices
    #fix or trash this ^^^^
    joins(:item)
    .where('items.id = invoice_items.item_id')
    .joins(:discounts)
    .where('invoice_items.quantity >= discounts.quantity_threshold')
    .each do |ii|
      ii.item.discounts.each do |discount|
        if ii.quantity >= discount.quantity_threshold
          ii.update(unit_price: (ii.unit_price * discount.percentage_discount))
        end
      end
    end
  end

  def applied_discount
    item
      .merchant
      .discounts
      .order(quantity_threshold: :asc)
      .where('quantity_threshold >= ?', self.quantity)
      .first
  end

  def adjust_price
    update(unit_price: (unit_price - (unit_price * applied_discount.percentage_discount)))
    self
  end
end
