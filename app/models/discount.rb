class Discount < ApplicationRecord
  validates_presence_of :percent_discount,
                        :quantity,
                        :merchant

  belongs_to :merchant 
end
