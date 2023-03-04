require 'rails_helper'

RSpec.describe 'merchant/:merchant_id/bulk_discounts/:bulk_discount_id', type: :feature do
  before :each do 
    @merchant1 = Merchant.create!(name: 'The Frisbee Store')

    @bd_basic = @merchant1.bulk_discounts.create!(title: "Basic", percentage_discount: 0.1, quantity_threshold: 2)

    visit merchant_bulk_discount_path(@merchant1, @bd_basic)
  end
  
  context "As a merchant, when I visit the bulk discounts show page" do
    # User Story 4
    it "I see the bulk discount's quantity threshold and percentage discount" do 
      expect(page).to have_content("Details for Bulk Discount: #{@bd_basic.title}")
      expect(page).to have_content("Precentage Discount (as a decimal): #{@bd_basic.percentage_discount}")
      expect(page).to have_content("Quantity Threshold (for same item): #{@bd_basic.quantity_threshold}")
    end

    # User Story 5
    it "I see a link to edit the bulk discount" do
      expect(page).to have_link("Update this Bulk Discount", href: "/merchant/#{@merchant1.id}/bulk_discounts/#{@bd_basic.id}/edit")
    end

    # User Story 5
    it "when I click on this link & am taken to that bulk discount's edit page" do
      click_link("Update this Bulk Discount")
      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @bd_basic))
    end
    
  end
end