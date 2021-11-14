require 'rails_helper'

RSpec.describe 'merchant discounts' do
  before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @merchant2 = Merchant.create!(name: 'Ted')

      @discount1 = Discount.create!(percentage_discount: 20, quantity_threshold: 5, merchant_id: @merchant1.id)
      @discount2 = Discount.create!(percentage_discount: 25, quantity_threshold: 7, merchant_id: @merchant2.id)
      @discount3 = Discount.create!(percentage_discount: 30, quantity_threshold: 2, merchant_id: @merchant1.id)

      visit merchant_discount_path(@merchant1, @discount1)
  end

  it "shows the discount's attributes" do
    expect(page).to have_content(@discount1.percentage_discount)
    expect(page).to have_content(@discount1.quantity_threshold)
    expect(page).not_to have_content(@discount2.percentage_discount)
    expect(page).not_to have_content(@discount2.quantity_threshold)
  end
end
