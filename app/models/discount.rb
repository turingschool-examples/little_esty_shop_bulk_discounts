class Discount < ApplicationRecord
  belongs_to :merchant

  validates :discount, presence: true, numericality: {only_float: true}
  validates :quantity, presence: true, numericality: {only_integer: true }
end
