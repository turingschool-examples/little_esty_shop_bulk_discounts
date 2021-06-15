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

  def apply_discount
    discount = item
                .merchant
                .discounts
                .order(quantity_threshold: :desc)
                .where('quantity_threshold <= ?', quantity)
                .first
    if discount == nil
      update(discounted_price: (unit_price))
    else
      update(discounted_price: (unit_price - (unit_price * discount.percentage_discount)))
    end
  end

  def has_discount?
    if unit_price == discounted_price
      return false
    else
      true
    end
  end

  def applied_discount
     item
        .merchant
        .discounts
        .order(quantity_threshold: :desc)
        .where('quantity_threshold <= ?', quantity)
        .pluck(:id)
        .first
  end
end
