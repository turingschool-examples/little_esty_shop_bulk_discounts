require 'rails_helper'

RSpec.describe 'merchants bulk discounts new page' do
  before :each do
    test_data
    visit new_merchant_bulk_discount_path(@merchant1)
  end

  describe 'As a merchant, when I visit my bulk discounts new page' do   
    it 'I see a form to add a new bulk discount' do
      expect(page).to have_field("Discount Name")
      expect(page).to have_field("Enter in a Discount Percent in the form of a float")
      expect(page).to have_field("Quantity Threshold")
      expect(page).to have_button("Create Bulk Discount")
    end

    it 'When I fill in the form with valid data, 
      then I am redirected back to the bulk discount index
      and I see my new bulk discount listed' do
      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
      
      fill_in 'Discount Name', with: "Summer Super Savings Sale"
      fill_in 'Enter in a Discount Percent in the form of a float', with: 15.00
      fill_in 'Quantity Threshold', with: 10

      click_button 'Create Bulk Discount'

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    end

    it 'if I leave a field empty, the new discount is not created and
      I am asked to fill out the form correctly.' do
      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
      
      fill_in 'Discount Name', with: "Summer Super Savings Sale"
      fill_in 'Enter in a Discount Percent in the form of a float', with: 15.00

      click_button 'Create Bulk Discount'

      expect(page).to have_field("Discount Name")
      expect(page).to have_field("Enter in a Discount Percent in the form of a float")
      expect(page).to have_field("Quantity Threshold")
      expect(page).to have_button("Create Bulk Discount")
      expect(page).to have_content("Please fill in all fields, did you not read?")
    end
  end
end