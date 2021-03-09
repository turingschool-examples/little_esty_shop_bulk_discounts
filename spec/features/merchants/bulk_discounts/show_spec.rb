require 'rails_helper'

RSpec.describe 'Merchant Bulk Discounts Show' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Hair Care')
    @discount_1 = BulkDiscount.create!(name:"small discount", percentage_discount: 10, quantity_threshold: 10, merchant_id: @merchant_1.id)
    @discount_2 = BulkDiscount.create!(name:"medium discount", percentage_discount: 15, quantity_threshold: 14, merchant_id: @merchant_1.id)
    @discount_3 = BulkDiscount.create!(name:"huge discount", percentage_discount: 20, quantity_threshold: 20, merchant_id: @merchant_1.id)
    @discount_4 = create(:bulk_discount, merchant_id: @merchant_1.id)
  end

  describe "As a merchant" do
    it "When I visit my bulk discount show page" do
      visit merchant_bulk_discount_path(@merchant_1, @discount_1)

      expect(page).to have_content(@discount_1.name)
      expect(page).to have_content(@discount_1.discount_int)
      expect(page).to have_content(@discount_1.quantity_threshold)
    end
  end
end
