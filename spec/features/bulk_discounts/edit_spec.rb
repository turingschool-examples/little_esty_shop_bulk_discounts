require 'rails_helper'

RSpec.describe 'bulk discount edit' do
  before :each do
    @merchant = Merchant.create!(name: 'Hair Care')

    @bulk_discount = BulkDiscount.create(discount: "5%", quantity: 10, merchant: @merchant)

    visit merchant_bulk_discount_path(@merchant, @bulk_discount)
  end

  describe "User Story 5" do
    context "As a merchant when I visit my bulk discount edit page" do
      it "I see that the discounts current attributes are pre-poluated in the form.
        When I change any/all of the information and click submit I am redirected to the 
        bulk discount's show page seeing that the discount's attributes have been updated" do
        
        expect(page).to have_content("Discount ID##{@bulk_discount.id}")
        expect(page).to have_content("Discount: #{@bulk_discount.discount}")
        expect(page).to have_content("Item Threshold: #{@bulk_discount.quantity}")
      end
    end
  end
end