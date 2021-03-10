class BulkDiscount < ApplicationRecord


  validates_presence_of :name,
                        :percentage_discount,
                        :quantity_threshold,
                        :merchant_id
  # validates_numericality
  validates_inclusion_of :percentage_discount, :in => 0.01..0.99
  validates :percentage_discount, numericality: true
  validates :quantity_threshold, numericality: true

  belongs_to :merchant


  def discount_int
    (percentage_discount * 100).to_i
  end
end
