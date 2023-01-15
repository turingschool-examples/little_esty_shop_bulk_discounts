class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants

  enum status: [:cancelled, 'in progress', :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  # def total_discounted_revenue
  #   # require 'pry'; binding.pry
  #   individual_discounted_prices = []
  #   invoice_items.each do |item|
  #     if item.quantity 

  #     end
  #   end
  # end
end
