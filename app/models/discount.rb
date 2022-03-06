class Discount < ApplicationRecord
  belongs_to :merchant

  has_many :items, through: :merchant
  has_many :invoice_items, through: :items

  validates :percent_discount, presence: true, numericality: {only_integer: true}
  validates :threshold, presence: true, numericality: {only_integer: true}

  def format_discount
    percent_discount.to_s+ "%"
  end
end
