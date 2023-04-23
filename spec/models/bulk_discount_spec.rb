require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')
    
    @bulk_discount_1 = BulkDiscount.create!(percentage_discount: 10, quantity_threshold: 10, merchant_id: @merchant1.id)
    @bulk_discount_2 = BulkDiscount.create!(percentage_discount: 25, quantity_threshold: 15, merchant_id: @merchant1.id)
    @bulk_discount_3 = BulkDiscount.create!(percentage_discount: 50, quantity_threshold: 20, merchant_id: @merchant2.id)
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many(:items).through(:merchant) }
  end

  describe 'validations' do
    it { should validate_presence_of :percentage_discount }
    it { should validate_presence_of :quantity_threshold }
    it { should validate_numericality_of :percentage_discount }
    it { should validate_numericality_of :quantity_threshold }
  end

  describe 'instance methods' do
    describe '#bulk_discount_merchant' do
      it 'returns the merchant of the bulk discount' do
        expect(@bulk_discount_1.bulk_discount_merchant).to eq(@merchant1)
        expect(@bulk_discount_2.bulk_discount_merchant).to eq(@merchant1)
        expect(@bulk_discount_3.bulk_discount_merchant).to eq(@merchant2)
      end
    end
  end
end
