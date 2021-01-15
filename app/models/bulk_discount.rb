class BulkDiscount < ApplicationRecord
  validates_presence_of :name,
                        :discount,
                        :threshold,
                        :merchant

  belongs_to :merchant

  def discount_to_percentage
    (self.discount * 100).round
  end

end
