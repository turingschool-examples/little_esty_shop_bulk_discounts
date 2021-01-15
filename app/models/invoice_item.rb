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

  def discount

    # potential_discounts = []
    # merchant.bulk_discounts.each do |discount|
    #   if discount.threshold <= self.quantity
    #     potential_discounts << discount
    #   end
    # end
    # if potential_discounts.length <= 1
    #   potential_discounts
    # else
    #   potential_discounts = potential_discounts.max(:threshold)
    # if potential_discounts.length <= 1
    #   potential_discounts
    # else
    #   potential_discounts = potential_discounts.max(:discount)
  
  end

  def revenue
    self.unit_price * self.quantity
  end
end
