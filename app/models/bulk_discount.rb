class BulkDiscount < ApplicationRecord
  validates_presence_of :percentage_discount, :quantity_threshold, :promo_name
  belongs_to :merchant
  has_many :items, through: :merchant
end