require 'rails_helper'

describe 'new discount page' do
  before do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    visit new_merchant_discount_path(@merchant1)
  end
  
  it 'has a form to create discount' do
    expect(page).to have_field("Discount Name")
    expect(page).to have_field("Minimum Quantity")
    expect(page).to have_field("Percent Off")
  end
end
