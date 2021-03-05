class Discount < ApplicationRecord
  validates_presence_of :quantity,
                        :percentage
  
  belongs_to :merchant
end