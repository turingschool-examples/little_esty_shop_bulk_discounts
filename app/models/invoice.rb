class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def adjust_price
    invoice_items.each do |ii|
      ii.apply_discount
    end
  end

  def total_discounted_revenue
    self.adjust_price
    invoice_items.sum('discounted_price * quantity')
  end
end
