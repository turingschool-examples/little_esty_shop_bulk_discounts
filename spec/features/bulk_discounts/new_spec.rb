require 'rails_helper'

RSpec.describe 'bulk discount new' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Hair Care')
  end
  
  describe "User Story 2" do
    context "As a merchant when I visit my bulk discounts index" do
      it "I see a link to create a new discount, clicking this link I am taken to a new page where I see a form to add a new discount.
        When I fill in the form with valid data I am redirected back to the bulk discount index and my new bulk discount is listed" do
        
        visit merchant_bulk_discounts_path(@merchant_1)
      
        click_link("Create New Discount")
        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1))
   
        fill_in "Discount", with: 50
        fill_in "Quantity", with: 75
        click_button "Create New Discount"
  
        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))
        expect(page).to have_content("Discount: 50%")
        expect(page).to have_content("Item Threshold: 75")
      end

      it "When I don't fill out the form with any input, 
        I see an error message and I stay on the edit page" do
        
        visit new_merchant_bulk_discount_path(@merchant_1)

        fill_in "Discount", with: ""
        fill_in "Quantity", with: ""
        click_button "Create New Discount"

        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1))
        expect(page).to have_content("Unable to Create - Missing Information")
      end

      it "When I fill out the form with negative numbers, 
        I see an error message and I stay on the edit page" do
        
        visit new_merchant_bulk_discount_path(@merchant_1)

        fill_in "Discount", with: -1
        fill_in "Quantity", with: -1
        click_button "Create New Discount"
        
        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1))
        expect(page).to have_content("Unable to Create - Missing Information")
      end
    end
  end
end