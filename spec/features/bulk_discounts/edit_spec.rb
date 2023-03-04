require 'rails_helper'

RSpec.describe 'merchant/:merchant_id/bulk_discounts/:bulk_discount_id/edit', type: :feature do
  before :each do 
    @merchant1 = Merchant.create!(name: 'The Frisbee Store')

    @bd_basic = @merchant1.bulk_discounts.create!(title: "Basic", percentage_discount: 0.1, quantity_threshold: 2)

    visit edit_merchant_bulk_discount_path(@merchant1, @bd_basic)
  end
  
  context "As a merchant, when I visit the bulk discounts edit page" do
    # User Story 5
    it "I see a form to edit the bulk discount with pre-populated attributes visible in the form fields" do 
      expect(page).to have_content("Edit Bulk Discount")
      expect(page).to have_field(:title, :with => "Basic")
      expect(page).to have_field(:percentage_discount, :with => 10)
      expect(page).to have_field(:quantity_threshold, :with => 2)
      expect(page).to have_button("Submit")
    end

    # User Story 5  
    xit "when I change any/all of the info & click submit, I'm redirected to it's show page & see the updated info" do
    end
  end
end