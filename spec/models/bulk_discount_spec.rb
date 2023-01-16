require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'validations' do
    it { should validate_presence_of :percentage_discount }
    it { should validate_numericality_of(:percentage_discount).is_less_than(1).is_greater_than(0) }
    it { should validate_presence_of :quantity_threshold }
    it { should validate_numericality_of(:quantity_threshold).only_integer.is_greater_than(0) }
  end

  describe 'relationships' do
    it { should belong_to :merchant}
  end

  describe 'getter/setter methods' do
    describe '#sanitized_percentage' do
      it 'returns santized percentages' do
        merchant = Merchant.create!(name: 'Merchant')
        discount = merchant.bulk_discounts.create!(percentage_discount: 0.75, quantity_threshold: 10)
        
        expect(discount.sanitized_percentage).to eq(75)
        
        discount.sanitized_percentage=(22)
        
        expect(discount.percentage_discount).to eq(0.22)

        discount.sanitized_percentage=("")

        expect(discount.percentage_discount).to eq(nil)
      end
    end
  end
end