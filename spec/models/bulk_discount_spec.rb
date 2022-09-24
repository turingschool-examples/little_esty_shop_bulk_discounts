require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many(:items).through(:merchant) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :percent_off}
    it { should validate_presence_of :quantity}
    it { should validate_numericality_of :quantity}
    it { should validate_presence_of :merchant_id}
    it { should define_enum_for(:status).with_values([:disabled, :enabled])}
  end
  # 
  # describe 'methods' do
  #
  #
  # end
end
