class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant

  validates_presence_of :percentage_discount, numericality: { only_integer: true, greater_than: 0, less_than: 50 }
  validates_presence_of :quantity_threshold, numericality: { only_integer: true }

  def bulk_discount_merchant
    merchant
  end
end
