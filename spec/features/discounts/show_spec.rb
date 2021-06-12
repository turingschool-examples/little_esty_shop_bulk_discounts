require 'rails_helper'

RSpec.describe 'merchant discounts index' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @discount1 = Discount.create!(percentage_discount: 0.25, quantity_threshold: 5, merchant_id: @merchant1.id)
    @discount2 = Discount.create!(percentage_discount: 0.50, quantity_threshold: 10, merchant_id: @merchant1.id)

    visit merchant_discount_path(@merchant1, @discount1)
  end
  #   Merchant Bulk Discount Show

  # As a merchant
  # When I visit my bulk discount show page
  # Then I see the bulk discount's quantity threshold and percentage discount
  it 'shows the discounts attributes' do
    expect(page).to have_content(@discount1.id)
    expect(page).to have_content(@discount1.percentage_discount)
    expect(page).to have_content(@discount1.quantity_threshold)
  end
end
