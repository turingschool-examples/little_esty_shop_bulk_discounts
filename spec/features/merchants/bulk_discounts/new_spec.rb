require 'rails_helper'

RSpec.describe "Create new bulk discount" do
  describe 'User story 2 (part 2)' do
    it 'has a form to add a new bulk discount' do
      merchant_1 = create(:merchant)

      visit merchant_bulk_discounts_path(merchant_1)

      click_link('Create bulk discount')

      fill_in('quantity_threshold', with: 20)
      fill_in('Percentage', with: 15)
    
      click_button('Create Bulk Discount')
      
      expect(current_path).to eq(merchant_bulk_discounts_path(merchant_1))
      expect(page).to have_content("Quantity Threshold: 20")
      expect(page).to have_content("Percentage: 15")
    end
  end
end