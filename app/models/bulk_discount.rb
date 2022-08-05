class BulkDiscount < ApplicationRecord
  validates_presence_of :name, presence: true
  validates_presence_of :percentage, inclusion: [0, 20, 30], presence: true
  validates_presence_of :quantity, presence: true

  belongs_to :merchant
  has_many :items, through: :merchant
end
