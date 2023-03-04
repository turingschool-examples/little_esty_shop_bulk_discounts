require 'rails_helper'

RSpec.describe 'merchant/:merchant_id/bulk_discounts/new', type: :feature do
  before :each do 
    @merchant1 = Merchant.create!(name: 'The Frisbee Store')
    
    visit new_merchant_bulk_discount_path(@merchant1.id)
  end

  context "As a merchant, when I visit the bulk discounts new page" do 
    # User Story 2
    it "I see a form to add a new bulk discount" do
      expect(page).to have_content("Create a New Bulk Discount")
      # expect(page).to have_selector("form")
      expect(page).to have_field(:title)
      expect(page).to have_field(:percentage_discount)
      expect(page).to have_field(:quantity_threshold)
      expect(page).to have_button("Create Discount")
    end

    # User Story 2
    it "when I fill in the form with valid data, I'm redirected to the bd index page & I see my new bd" do
      fill_in("Title", with: "Seasonal")
      fill_in("Precentage Discount:", with: "Seasonal")
      fill_in("Precentage Discount:", with: "Seasonal")
    end
    
    # User Story 2 - Sad Path Test
    # fill in form with wrong data, flash message appears

  end
end