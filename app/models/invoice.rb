class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  #US 6
  def discounted_revenue(merchant_id)
    discounted_items(merchant_id).sum do |ii|
      ii.quantity * (ii.unit_price - (ii.unit_price * ii.max_discount / 100))
      #unit_price and max_discount is going to give you a number that will equal the percentage of that unit_price
      #when divided by 100
      #we then subtract that from the unit_price to get the discounted price and multiply by the quantity
    end.round(2)
  end

  def discounted_items(merchant_id)
    invoice_items.joins(:bulk_discounts)
    .where(merchants: {id: merchant_id})
    .where("invoice_items.quantity >= bulk_discounts.threshold")
    .group(:id)
    .select("max(bulk_discounts.percentage) as max_discount, invoice_items.*")
    #select the highest percentage discount that the quantity applies to
  end
end
