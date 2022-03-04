class BulkDiscount < ApplicationRecord
  validates_presence_of :percentage,
                        :threshold
  validates :percentage,
            numericality: { less_than_or_equal_to: 100, greater_than_or_equal_to: 1, only_integer: true }
  validates :threshold, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  belongs_to :merchant
end
