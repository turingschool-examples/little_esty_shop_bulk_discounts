require "rails_helper"

RSpec.describe "Merchant Bulk Discount Show Page" do
  before(:each) do 
    @merchant_1 = Merchant.create!(name: 'Hair Care')
  
    @bulk_discount_1 = BulkDiscount.create!(merchant: @merchant_1, quantity_threshold: 5, percentage_discount: 15)

    visit merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)
  end

  context "User Story 4" do
    describe 'As a merchant' do
      describe "When I visit my bulk discount show page" do
        it "can see the bulk discount's quantity threshold and percentage discount" do
          expect(page).to have_content("Bulk Discount ID: #{@bulk_discount_1.id}")
          expect(page).to have_content("Quantity Threshold: 5 units")
          expect(page).to have_content("Percentage Discount: 15%")
        end
      end
    end
  end
end