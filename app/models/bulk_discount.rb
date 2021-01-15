class BulkDiscount < ApplicationRecord
  validates_presence_of :name,
                        :discount,
                        :threshold,
                        :merchant

  belongs_to :merchant

  def discount_to_percentage
    (self.discount * 100).round
  end

  def self.best_discount(invoice_item)
    joins(merchant: :invoice_items)
    .select('bulk_discounts.*')
    .where('invoice_items.id = ?', invoice_item.id)
    .where('bulk_discounts.threshold <= ?', invoice_item.quantity)
    .order('bulk_discounts.discount desc')
    .limit(1).first
  end

end
