require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount Edit Page' do
  before :each do
    test_data
    @discount1 = @merchant1.bulk_discounts.create!(percentage_discount: 0.2, quantity_threshold: 10, promo_name: 'Buy 10, Get 20% Off')
    @discount2 = @merchant1.bulk_discounts.create!(percentage_discount: 0.3, quantity_threshold: 15, promo_name: 'Rewards Program')
    @discount3 = @merchant2.bulk_discounts.create!(percentage_discount: 0.42, quantity_threshold: 20, promo_name: 'National Haircut Day')
  end

  describe 'When I visit my bulk discount edit page' do
    it 'I see a form to edit the bulk discount attributes' do
      visit edit_merchant_bulk_discount_path(@merchant1, @discount1)
      expect(page).to have_field("Percentage Discount", with: @discount1.percentage_discount)
      expect(page).to have_field("Quantity Threshold", with: @discount1.quantity_threshold)
      expect(page).to have_field("Name", with: @discount1.promo_name)

      fill_in 'Percentage Discount', with: 0.15
      fill_in 'Quantity Threshold', with: 15
      click_button 'Submit'

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
      expect(page).to have_content("Discount: 15.0%")
      expect(page).to have_content("Quantity Threshold: 15")
      expect(page).to have_content("Buy 10, Get 20% Off")
      expect(page).to_not have_content("Percentage Discount: 20.0%")
      expect(page).to_not have_content("Quantity Threshold: 10")
    
      visit edit_merchant_bulk_discount_path(@merchant1, @discount2)

      fill_in 'Percentage Discount', with: 0.25
      fill_in 'Quantity Threshold', with: 20
      fill_in 'Name', with: 'Buy 20, Get 25% Off'
      click_button 'Submit'

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount2))
      expect(page).to have_content("Discount: 25.0%")
      expect(page).to have_content("Quantity Threshold: 20")
      expect(page).to have_content("Buy 20, Get 25% Off")
      expect(page).to_not have_content("Percentage Discount: 30.0%")
      expect(page).to_not have_content("Quantity Threshold: 15")
      expect(page).to_not have_content("Rewards Program")
    end
  end
end