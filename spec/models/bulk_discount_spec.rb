require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many(:items).through(:merchant) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do

    it { should validate_presence_of(:name)}
    it { should validate_numericality_of(:percentage_discount)}
    it { should validate_numericality_of(:quantity_threshold)}

    it 'validates name' do
      merchant1 = Merchant.create!(name: 'Hair Care')
      bulk_discount = BulkDiscount.new
      bulk_discount.name = ''
      bulk_discount.validate
      expect(bulk_discount.errors[:name]).to include("can't be blank")
    end

    it 'validates it is not kyle' do
      merchant1 = Merchant.create!(name: 'Hair Care')
      bulk_discount = BulkDiscount.new
      bulk_discount.name = 'kyle'
      bulk_discount.validate
      expect(bulk_discount.errors[:name]).to include("Nice, try. Don't put this on Kyle! He doesn't even work here!")
    end

    it 'validates it is a number between 1 and 99' do
      merchant1 = Merchant.create!(name: 'Hair Care')
      bulk_discount = BulkDiscount.new
      bulk_discount.percentage_discount = 101
      bulk_discount.validate
      expect(bulk_discount.errors[:percentage_discount]).to include("Please enter a number 1-99")
    end
  end
end
