require 'rails_helper'

RSpec.describe 'merchant/:merchant_id/bulk_discounts', type: :feature do
  before :each do 
    @merchant1 = Merchant.create!(name: 'The Frisbee Store')

    @bd_basic = @merchant1.bulk_discounts.create!(title: "Basic", percentage_discount: 0.2, quantity_threshold: 2)
    @bd_super = @merchant1.bulk_discounts.create!(title: "Super", percentage_discount: 0.25, quantity_threshold: 5)

    visit merchant_bulk_discounts_path(@merchant1)
  end

  context "As a merchant, when I visit my bulk discounts index page" do
    # User Story 1
    it "I see all my bulk discounts info which includes a link to it's show page" do
      expect(page).to have_content("All Available Bulk Discounts")
      
      within "#bd-#{@bd_basic.id}" do
        expect(page).to have_content("The #{@bd_basic.title}:")
        expect(page).to have_content("20% off #{@bd_basic.quantity_threshold} of the same item")
        expect(page).to have_link("See More", href: "/merchant/#{@merchant1.id}/bulk_discounts/#{@bd_basic.id}")    
      end

      within "#bd-#{@bd_super.id}" do
        expect(page).to have_content("The #{@bd_super.title}:")
        expect(page).to have_content("25% off #{@bd_super.quantity_threshold} of the same item")
        expect(page).to have_link("See More", href: "/merchant/#{@merchant1.id}/bulk_discounts/#{@bd_super.id}")
      end
    end
  end
end