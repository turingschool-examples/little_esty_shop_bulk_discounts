require "rails_helper"

RSpec.describe "Bulk Discount Show Page", type: :feature do
  before :each do
    @merchant = Merchant.create!(name: 'Hair Care')
    @discount_1 = @merchant.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 20)
    @discount_2 = @merchant.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 30)
    @discount_3 = @merchant.bulk_discounts.create!(percentage_discount: 40, quantity_threshold: 40)
    visit merchant_bulk_discounts_path(@merchant)
    click_link("Discount ##{@discount_1.id}")
  end
  describe "As a merchant" do
    describe "When I visit my bulk discounts show page" do
      it " I see the bulk discount's quantity threshold and percentage discount" do
        expect(page).to have_content("Discount ##{@discount_1.id}'s Information")
        expect(page).to have_content("Percentage off: #{@discount_1.percentage_discount}")
        expect(page).to have_content("Minimum number of Items: #{@discount_1.quantity_threshold}")
        expect(page).to have_no_content(@discount_2.percentage_discount)
        expect(page).to have_no_content(@discount_2.quantity_threshold)
        expect(page).to have_no_content(@discount_3.percentage_discount)
        expect(page).to have_no_content(@discount_3.quantity_threshold)
      end
    end
  end
end