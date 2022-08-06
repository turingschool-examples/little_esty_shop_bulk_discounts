require 'rails_helper'

RSpec.describe 'merchant bulk discounts show page' do

  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Po House Pub')

    @discount_1 = BulkDiscount.create!(percentage_discount: 5, quantity:  10, merchant_id: @merchant1.id)
    @discount_2 = BulkDiscount.create!(percentage_discount: 78, quantity:  68, merchant_id: @merchant2.id)

    visit merchant_bulk_discount_path(@merchant1, @discount_1)
  end

  it 'displays the bulk discounts quantity threshold and percentage discount' do

      expect(page).to have_content('Percentage Discount: 5')
      expect(page).to have_content('Quantity: 10')

      expect(page).to_not have_content('Percentage Discount: 78')
      expect(page).to_not have_content('Quantity: 68')
  end

end
