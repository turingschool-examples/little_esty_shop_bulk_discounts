class BulkDiscount < ApplicationRecord
  validates_presence_of :name, presence: true
  validates_presence_of :percentage, presence: true, :inclusion => 1..100
  validates_presence_of :quantity, presence: true

  belongs_to :merchant
  has_many :items, through: :merchant
end
