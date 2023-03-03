require 'rails_helper'

RSpec.describe 'bulk discount index' do
  before :each do
    @merchant = Merchant.create!(name: 'Hair Care')

    @bulk_discount = BulkDiscount.create(discount: "5%", quantity: 10, merchant: @merchant)

    visit merchant_bulk_discount_path(@merchant, @bulk_discount)
  end

  describe "User Story 4" do
    context "As a merchant when I visit my bulk discount show page" do
      it "I see the bulk discount's quantity threshold and percentage discount" do
        save_and_open_page
        expect(page).to have_content("Discount ID##{@bulk_discount.id}")
        expect(page).to have_content("Discount: #{@bulk_discount.discount}")
        expect(page).to have_content("Item Threshold: #{@bulk_discount.quantity}")
      end
    end
  end
end