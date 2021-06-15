class Discount < ApplicationRecord
  validates_presence_of :percentage_discount,
                        :quantity_threshold

  belongs_to :merchant
  has_many :items
  has_many :items, through: :merchant
  has_many :invoice_items
  has_many :invoice_items, through: :items
end
