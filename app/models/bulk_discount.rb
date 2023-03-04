class BulkDiscount < ApplicationRecord
  validates_presence_of :percentage_discount,
                        :quantity_threshold
  # validate do |bulk_discount|
  #   errors.add :percentage_discount, :negative_value, message: "cannot have a negative value"
  # end

  belongs_to :merchant
  has_many :items, through: :merchant

end