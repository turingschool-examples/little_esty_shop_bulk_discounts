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

  def has_discount?
    discounts = bulk_discounts
      .joins(:invoice_items)
      .where("invoice_items.quantity >= bulk_discounts.quantity_threshold AND invoice_items.id = #{id}")
      !discounts.empty?
  end
end
