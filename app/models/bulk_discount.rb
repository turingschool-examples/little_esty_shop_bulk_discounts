class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant

  validates_numericality_of :percentage_discount, { only_integer: true, greater_than: 0 }
  validates_numericality_of :quantity_threshold, { only_integer: true, greater_than: 0 }

  def bulk_discount_merchant
    merchant
  end
end
