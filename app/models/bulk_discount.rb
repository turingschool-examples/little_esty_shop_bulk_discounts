class BulkDiscount < ApplicationRecord
  validates :percentage_discount, presence: true, numericality: {less_than: 1, greater_than: 0}
  validates :quantity_threshold, presence: true, numericality: {only_integer: true, greater_than: 0}
  belongs_to :merchant

  def sanitized_percentage
    (self[:percentage_discount] * 100).to_int if self[:percentage_discount]
  end

  def sanitized_percentage=(value)
    self[:percentage_discount] = (value.to_f/100.0) if value.present?
  end
end