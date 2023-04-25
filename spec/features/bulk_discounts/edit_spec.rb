require 'rails_helper'

RSpec.describe "merchant bulk discounts edit page" do
  describe "when I visit my bulk discounts edit page" do
    before(:each) do
      @merch_1 = create(:merchant)
      @merch_2 = create(:merchant)
      @bulk_discount_1 = @merch_1.bulk_discounts.create!(percent_discount: 15, quantity_threshold: 10)
      @bulk_discount_2 = @merch_1.bulk_discounts.create!(percent_discount: 25, quantity_threshold: 2)
      @bulk_discount_3 = @merch_2.bulk_discounts.create!(percent_discount: 10, quantity_threshold: 5)
    end

    it 'displays a fillable form to edit the discount' do
      visit edit_merchant_bulk_discount_path(@merch_1, @bulk_discount_2)

      within("#edit-discount-form") do
        expect(page).to have_field("bulk_discount_percent_discount")
        expect(page).to have_field("bulk_discount_quantity_threshold")
      end
    end

    it 'allows you to fill out form and submit' do
      visit edit_merchant_bulk_discount_path(@merch_1, @bulk_discount_2)

      fill_in "bulk_discount_percent_discount", with: 30.0
      fill_in "bulk_discount_quantity_threshold", with: 8
      click_button "Add Discount"

      expect(current_path).to eq(merchant_bulk_discount_path(@merch_1, @bulk_discount_2))
    end
  end
end