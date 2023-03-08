require 'rails_helper'

RSpec.describe 'bulk discount edit' do
  before :each do
    @merchant = Merchant.create!(name: 'Hair Care')
    @bulk_discount = BulkDiscount.create(discount: 5, quantity: 10, merchant: @merchant)

    visit edit_merchant_bulk_discount_path(@merchant, @bulk_discount)
  end

  describe "User Story 5" do
    context "As a merchant when I visit my bulk discount edit page" do
      it "I see that the discounts current attributes are pre-poluated in the form.
        When I change any/all of the information and click submit I am redirected to the 
        bulk discount's show page seeing that the discount's attributes have been updated" do
        
        expect(page).to have_content("Discount ID##{@bulk_discount.id}")
        expect(page).to have_field("Discount", with: @bulk_discount.discount)
        expect(page).to have_field("Quantity", with: @bulk_discount.quantity)
        
        fill_in :discount, with: 20
        fill_in :quantity, with: 15
        
        click_button "Update Discount"
        
        expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @bulk_discount))
        expect(page).to have_content("Discount ID##{@bulk_discount.id}")
        expect(page).to have_content("Discount: 20%")
        expect(page).to have_content("Item Threshold: 15")
      end

      it "When I don't fill out the form with any input, 
        I see an error message and I stay on the edit page" do
        
        fill_in :discount, with: nil
        fill_in :quantity, with: nil
        
        click_button "Update Discount"
        
        expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant, @bulk_discount))
        expect(page).to have_content("Unable to Update - Missing Information")
      end

      it "When I fill out the form with negative numbers, 
        I see an error message and I stay on the edit page" do
        
        fill_in :discount, with: -1
        fill_in :quantity, with: -1
        
        click_button "Update Discount"
        
        expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant, @bulk_discount))
        expect(page).to have_content("Unable to Update - Missing Information")
      end
    end
  end
end