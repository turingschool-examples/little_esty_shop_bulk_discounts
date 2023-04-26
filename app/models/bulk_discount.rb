class BulkDiscount < ApplicationRecord
  validates_presence_of :percentage_discount, :quantity_threshold, :promo_name
  validates_numericality_of :percentage_discount, greater_than: 0, less_than: 1.00
  validates_numericality_of :quantity_threshold, greater_than: 0, only_integer: true
  belongs_to :merchant
  has_many :items, through: :merchant
end