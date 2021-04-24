class Transaction < ApplicationRecord
  belongs_to :invoice
  has_many :customers, through: :invoice

  validates_presence_of :invoice_id,
                        :credit_card_number,
                        :result
  enum result: [:failed, :success]
end
