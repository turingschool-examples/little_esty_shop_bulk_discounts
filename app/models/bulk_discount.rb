class BulkDiscount < ApplicationRecord
  validates :percent_discount, 
            :quantity_threshold, 
             numericality: true,
             presence: true

  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
end
