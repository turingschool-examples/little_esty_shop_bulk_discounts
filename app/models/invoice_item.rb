class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item
  has_many :discounts, through: :merchant

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def discount
    discounts
    .where('quantity_threshold <= ?', "#{self.quantity}")
    .order(percentage_discount: :desc).first
    # ii_discounts = self.item.merchant.discounts.map do |discount|
    #   if self.quantity > discount.quantity_threshold
    #     discount.percentage_discount
    #   else
    #     0
    #   end
    # end
    # max_discount = ii_discounts.max
    # max_discount.nil? ? 0 : (max_discount.to_f / 100)
  end

  def revenue
    if discount == nil
      unit_price * quantity
    else
      unit_price * quantity * (1 - (discount.percentage_discount.to_f / 100))
    end
  end

  # def max_discount
  #   discounts =  []
  #   wip = self.item.merchant.discounts.each do |discount|
  #   if self.quantity > discount.quantity_threshold
  #       discounts << discount
  #     end
  #   end
  #   discounts.sort_by()
  #   require "pry"; binding.pry
  # end

  def discount_applied
    discount_percentage > 0
  end

  # def ii_discounted_revenue
  #   discount_total = self.unit_price * self.quantity * discount_percentage
  #   total = self.unit_price * self.quantity
  #   total - discount_total
  # end
end
