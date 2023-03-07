class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item
  # has_many :merchants, through: :invoice
  # has_many :bulk_discounts, through: :merchants

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  # def discount_revenue
  #   self.joins(:bulk_discounts)
  #   .select('invoice_items.id, MAX((invoice_items.quantity) * invoice_items.unit_price * percentage / 100) as discount_amt')
  #   .where('invoice_items.id = #{self.id} AND #{self.quatity} >= bulk_discounts.quantity_threshold')
  #   .group('invoice_items.id')
  #   .sum(&:discount_amt)
  # end
end
