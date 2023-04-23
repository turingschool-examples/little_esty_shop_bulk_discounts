require 'rails_helper'

RSpec.describe "merchant bulk discounts show page" do
  describe "when I visit my bulk discounts show page" do
    before(:each) do
      @merch_1 = create(:merchant)
      @merch_2 = create(:merchant)
      @bulk_discount_1 = @merch_1.bulk_discounts.create!(percent_discount: 15, quantity_threshold: 10)
      @bulk_discount_2 = @merch_1.bulk_discounts.create!(percent_discount: 25, quantity_threshold: 2)
      @bulk_discount_3 = @merch_2.bulk_discounts.create!(percent_discount: 10, quantity_threshold: 5)
    end

    it 'displays the bulk discounts quantity threshold and percentage discount' do
      visit merchant_bulk_discount_path(@merch_1, @bulk_discount_1)

      expect(page).to have_content("Percentage Off: 15.0%")
      expect(page).to_not have_content("Percentage Off: 25.0%")
    end
  end
end