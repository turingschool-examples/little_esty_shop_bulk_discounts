class Discount < ApplicationRecord
  validates_presence_of :name, :threshold, :percentage
  belongs_to :merchant
end
