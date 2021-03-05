class Discount < ApplicationRecord
  validates_presence_of :percent_discount,
                        :quantity

  validates :percent_discount, numericality: true
  validates :quantity, numericality: true

  belongs_to :merchant
end
