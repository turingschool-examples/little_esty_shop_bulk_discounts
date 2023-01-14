require 'rails_helper'

RSpec.describe "Create new bulk discount" do
  describe 'User story 2' do
    it 'has a link to create a new bulk discount' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      bulk_discount_1 = merchant_1.bulk_discounts.create!(quantity_threshold: 10, percentage: 5)
      bulk_discount_2 = merchant_1.bulk_discounts.create!(quantity_threshold: 15, percentage: 10)
      bulk_discount_3 = merchant_1.bulk_discounts.create!(quantity_threshold: 20, percentage: 20)
      bulk_discount_4 = merchant_1.bulk_discounts.create!(quantity_threshold: 30, percentage: 25)
      bulk_discount_5 = merchant_1.bulk_discounts.create!(quantity_threshold: 50, percentage: 30)

      customer_1 = create(:customer)

      items_1 = create_list(:item, 5, unit_price: 50)
      items = create_list(:item, 8, unit_price: 10)

      visit merchant_bulk_discounts_path(merchant_1)

      expect(page).to have_link('Create bulk discount')
    end

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