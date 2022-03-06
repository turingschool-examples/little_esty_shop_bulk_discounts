require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many(:items).through(:merchant) }
    it { should have_many(:invoice_items).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:percent_discount)}
    it { should validate_numericality_of(:percent_discount)}
    it { should validate_presence_of(:threshold)}
    it { should validate_numericality_of(:threshold)}
  end

  describe '#format_discount' do
    it 'presents a discount in a human-readable manor' do
      discount_1 = create(:discount)
      discount_2 = create(:discount, percent_discount: 35)


      expect(discount_1.format_discount).to eq("20%")
      expect(discount_2.format_discount).to eq("35%")
    end
  end
end
