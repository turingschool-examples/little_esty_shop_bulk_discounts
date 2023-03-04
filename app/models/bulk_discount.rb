# frozen_string_literal: true

class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :percent_discounted
  validates_presence_of :quantity_threshold
  validates :quantity_threshold, numericality: { only_integer: true, greater_than: 0 }
  validates :percent_discounted, numericality: { only_integer: true, greater_than: 0, less_than: 101 }
end
