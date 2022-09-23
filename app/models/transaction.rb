class Transaction < ApplicationRecord
  validates_presence_of :invoice_id,
                        :credit_card_number,
                        :result
  enum result: [:failed, :success]

  belongs_to :invoice
  has_many :bulk_discounts, through: :invoice
end
