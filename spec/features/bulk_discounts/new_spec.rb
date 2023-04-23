require 'rails_helper'

RSpec.describe "merchant bulk discounts new page" do
  describe "when I visit my bulk discounts new page" do
    before(:each) do
      @merch_1 = create(:merchant)
      @merch_2 = create(:merchant)
      @bulk_discount_1 =@merch_1.bulk_discounts.create!(percent_discount: 15, quantity_threshold: 10)
      @bulk_discount_2 =@merch_1.bulk_discounts.create!(percent_discount: 25, quantity_threshold: 2)
      @bulk_discount_3 =@merch_2.bulk_discounts.create!(percent_discount: 10, quantity_threshold: 5)
    end

    it 'displays a fillable form for new discounts' do
      visit new_merchant_bulk_discount_path(@merch_1)

      expect(page).to have_field("percent_discount")
      expect(page).to have_field("quantity_threshold")
    end

    it 'allows you to fill out form and submit' do
      visit new_merchant_bulk_discount_path(@merch_1)
save_and_open_page

      fill_in "percent_discount", with: 50.0
      fill_in "quantity_threshold", with: 10
      click_button "Add Discount"

      expect(current_path).to eq(merchant_bulk_discounts_path(@merch_1))

    end
  end
end
  