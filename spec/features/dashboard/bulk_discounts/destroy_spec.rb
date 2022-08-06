require 'rails_helper'

RSpec.describe 'merchant bulk discount delete' do

  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @discount_1 = BulkDiscount.create!(percentage_discount: 5, quantity:  10, merchant_id: @merchant1.id)
    @discount_2 = BulkDiscount.create!(percentage_discount: 10, quantity:  15, merchant_id: @merchant1.id)
    @discount_3 = BulkDiscount.create!(percentage_discount: 15, quantity:  20, merchant_id: @merchant1.id)
    @discount_4 = BulkDiscount.create!(percentage_discount: 20, quantity:  30, merchant_id: @merchant1.id)

    visit merchant_bulk_discounts_path(@merchant1)
  end

    it 'displays a link to delete a bulk discount' do

      within("#discount-#{@discount_1.id}") do
        expect(page).to have_link('Delete Discount')
        click_link 'Delete Discount'
        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
      end
    end
end
