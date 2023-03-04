require 'rails_helper'

RSpec.describe 'merchant/:merchant_id/bulk_discounts/new', type: :feature do
  before :each do 
    @merchant1 = Merchant.create!(name: 'The Frisbee Store')
    
    visit new_merchant_bulk_discount_path(@merchant1)
  end

  context "As a merchant, when I visit the bulk discounts new page" do 
    # User Story 2
    it "I see a form to add a new bulk discount" do
      expect(page).to have_content("Create a New Bulk Discount")
      expect(page).to have_field(:title)
      expect(page).to have_field(:percentage_discount)
      expect(page).to have_field(:quantity_threshold)
      expect(page).to have_button("Create Discount")
    end

    # User Story 2
    it "when I fill in the form with valid data, I'm redirected to the bd index page & I see my new bd" do
      fill_in("Title", with: "Seasonal")
      fill_in("Discount Precentage:", with: 20)
      select(6, from: "Quantity Threshold:")
      click_button("Create Discount")

      expect(current_path).to eq( "/merchant/#{@merchant1.id}/bulk_discounts")

      within "#bd-#{@merchant1.bulk_discounts.last.id}" do
        expect(page).to have_content("The Seasonal:")
        expect(page).to have_content("20% off 6 of the same item")
        expect(page).to have_link("See More", href: "/merchant/#{@merchant1.id}/bulk_discounts/#{@merchant1.bulk_discounts.first.id}")    
      end
    end
    
    # User Story 2 - Sad Path Test
    it "when I fill in the form with INVALID data, I see an error message" do
      fill_in("Title", with: "")
      fill_in("Discount Precentage:", with: 5)
      select(12, from: "Quantity Threshold:")
      click_button("Create Discount")
      expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/new")

      expect(page).to have_content("Title can't be blank")
    end
  end
end