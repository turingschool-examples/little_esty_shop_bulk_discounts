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

  def best_discount
    bulk_discounts 
      .where('quantity_threshold <= ?', quantity)
      .order(percentage_discount: :desc).first 
  end

  def prediscount_revenue
    quantity * unit_price
  end

  def total_discounted_revenue
    prediscount_revenue * (1 - ( best_discount&.percentage_discount || 0 ))
  end
end
