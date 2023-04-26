require 'rails_helper'

RSpec.describe 'Bulk Discounts New Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Body Care')
    @merchant3 = Merchant.create!(name: 'Skin Care')
    @merchant4 = Merchant.create!(name: 'Nail Care')

    @discount1 = @merchant1.bulk_discounts.create!(percentage_discount: 0.2, quantity_threshold: 10, promo_name: 'Buy 10, Get 20% Off')
    @discount2 = @merchant1.bulk_discounts.create!(percentage_discount: 0.3, quantity_threshold: 15, promo_name: 'Rewards Program')
    @discount3 = @merchant2.bulk_discounts.create!(percentage_discount: 0.42, quantity_threshold: 20, promo_name: 'National Haircut Day')

    visit new_merchant_bulk_discount_path(@merchant1)
  end

  describe 'When I visit my new bulk discount page' do
    it 'I see a form to add a new bulk discount' do
      fill_in 'Percentage Discount', with: 0.15
      fill_in 'Quantity Threshold', with: 15
      fill_in 'Name', with: 'Buy 15, Get 15% Off'
      click_button 'Create New Discount'

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
      
      expect(page).to have_link('Buy 15, Get 15% Off')
    end

    it 'redirects back to index if discount percentage and quantity are valid' do
      fill_in 'Percentage Discount', with: 0.15
      fill_in 'Quantity Threshold', with: 15

      click_button 'Create New Discount'

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
      expect(current_path).to_not eq(merchant_bulk_discounts_path(@merchant1))
    end

    it 'negative percentage discounts or quantity thresholds keeps you on the new discount page' do
      fill_in 'Percentage Discount', with: -0.15
      fill_in 'Quantity Threshold', with: 15
      fill_in 'Name', with: 'Buy 15, Get 15% Off'
      click_button 'Create New Discount'

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
    end
  end
end