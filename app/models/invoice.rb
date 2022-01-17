class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, 'in progress', :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_discounted_revenue 
    items.map do |item|
      item.total_item_discount(item, self)
    end.sum
  end

  # def total_discounted_revenue 
  #   items.map do |item|
  #     item.total_item_discount(item)
  #   end.sum
  # end

  # x = InvoiceItem.find_by(invoice_id: self.id)
  # y = Item.find(x.item_id)
  # z = BulkDiscount.where(merchant_id: y.merchant_id)
end
