class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :bulk_discounts_items
  has_many :items, through: :bulk_discounts_items
end