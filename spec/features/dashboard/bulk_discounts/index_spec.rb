require 'rails_helper'

RSpec.describe 'bulk discounts' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @discount_1 = BulkDiscount.create!(percentage_discount: 5, quantity:  10, merchant_id: @merchant1.id)
    @discount_2 = BulkDiscount.create!(percentage_discount: 10, quantity:  15, merchant_id: @merchant1.id)
    @discount_3 = BulkDiscount.create!(percentage_discount: 15, quantity:  20, merchant_id: @merchant1.id)
    @discount_4 = BulkDiscount.create!(percentage_discount: 20, quantity:  30, merchant_id: @merchant1.id)

    visit merchant_bulk_discounts_path(@merchant1)
  end

  it 'displays all merchant discounts and has a link to the show page' do

    within("#discount-#{@discount_1.id}") do
      expect(page).to have_content(@discount_1.percentage_discount)
      expect(page).to have_content(@discount_1.quantity)
    end

    within("#discount-#{@discount_2.id}") do
      expect(page).to have_content(@discount_2.percentage_discount)
      expect(page).to have_content(@discount_2.quantity)
    end
  end

  it 'displays a discount show page link' do

    within("#discount-#{@discount_1.id}") do
      click_link 'Discount Details'
      expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount_1))
    end
  end
end
