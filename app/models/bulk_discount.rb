class BulkDiscount < ApplicationRecord

  
  validates_presence_of :name,
                        :percentage_discount,
                        :quantity_threshold,
                        :merchant_id

  belongs_to :merchant


  def discount_int
    (percentage_discount * 100).to_i
  end
end
