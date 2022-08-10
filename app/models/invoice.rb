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

  def discounted_revenue
    @revenue = 0
    merchants.uniq.first.bulk_discounts.each do |discount|
      max_discount = 0
      invoice_items.each do |item|
        max_discount += discount.percentage_discount if discount.percentage_discount > max_discount
        if item.quantity >= discount.quantity_threshold
          @revenue += ((item.quantity * item.unit_price)-((discount.percentage_discount/100.to_f)*(item.quantity * item.unit_price)))
        end
      end
    end
    @revenue
  end

end
