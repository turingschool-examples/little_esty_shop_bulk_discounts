# frozen_string_literal: true

class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum('unit_price * quantity')
  end

  def discount_total_revenue
    max_discount_table =  InvoiceItem
                                    .joins(:item)
                                    .joins('LEFT JOIN bulk_discounts ON items.merchant_id = bulk_discounts.merchant_id AND invoice_items.quantity >= bulk_discounts.quantity_threshold')
                                    .where('invoice_items.invoice_id = ?', id)
                                    .select('invoice_items.*, MAX(bulk_discounts.percent_discounted) AS max_discount')
                                    .group(:id)
    table_sum(max_discount_table)
  end

  def merchant_total_revenue(merchant)
    invoice_items.joins(:item).where('items.merchant_id = ?', merchant.id).sum('invoice_items.unit_price * quantity')
  end

  def merchant_total_revenue_discounted(merchant)
    max_discount_table =  InvoiceItem
                                    .joins("INNER JOIN items ON invoice_items.item_id = items.id AND items.merchant_id = #{merchant.id}")
                                    .joins('LEFT JOIN bulk_discounts ON items.merchant_id = bulk_discounts.merchant_id AND invoice_items.quantity >= bulk_discounts.quantity_threshold')
                                    .where('invoice_items.invoice_id = ?', id)
                                    .select('invoice_items.*, MAX(bulk_discounts.percent_discounted) AS max_discount')
                                    .group(:id)
    table_sum(max_discount_table)
  end

private
  def table_sum(max_discount_table)
    max_discount_table.sum do |invoice_item|
      if invoice_item.max_discount
      ((100 - invoice_item.max_discount.to_f) / 100.to_f) * invoice_item.unit_price.to_f * invoice_item.quantity.to_f
      else
        invoice_item.unit_price.to_f * invoice_item.quantity.to_f
      end
    end
  end
end
