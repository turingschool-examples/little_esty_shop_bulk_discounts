class Discount < ApplicationRecord
  validates_presence_of :quantity,
                        :percentage

  belongs_to :merchant

  def percentage_threshhold

  end

  def quantity_threshhold

  end
end
