require 'rails_helper'

RSpec.describe 'Merchant Bulk Discounts Index' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Hair Care')
    @discount_1 = BulkDiscount.create!(name:"small discount", percentage_discount: 0.10, quantity_threshold: 10, merchant_id: @merchant_1.id)
    @discount_2 = BulkDiscount.create!(name:"medium discount", percentage_discount: 0.15, quantity_threshold: 14, merchant_id: @merchant_1.id)
    @discount_3 = BulkDiscount.create!(name:"huge discount", percentage_discount: 0.20, quantity_threshold: 20, merchant_id: @merchant_1.id)
    @discount_4 = create(:bulk_discount, merchant_id: @merchant_1.id)


  end

  describe "As a merchant" do
    it "When I visit my merchant dashboard i see a link to view all my discounts" do
      visit "/merchant/#{@merchant_1.id}/dashboard"

      expect(page).to have_link("Discounts")
    end

    it "When I click this link then I am taken to my bulk discounts index page" do
      visit "/merchant/#{@merchant_1.id}/dashboard"

      expect(page).to have_link("Discounts")
      click_link("Discounts")
      expect(current_path).to eq("/merchant/#{@merchant_1.id}/bulk_discounts")
    end

    it "I see all of my bulk discounts including their percentage discount and quantity thresholds" do
      visit "/merchant/#{@merchant_1.id}/bulk_discounts"

      within("#discount-#{@discount_1.id}") do
        expect(page).to have_content("Discount: #{@discount_1.discount_int}%")
        expect(page).to have_content("Quantity Threshold: #{@discount_1.quantity_threshold}")
      end
      within("#discount-#{@discount_2.id}") do
        expect(page).to have_content("Discount: #{@discount_2.discount_int}%")
        expect(page).to have_content("Quantity Threshold: #{@discount_2.quantity_threshold}")
      end
      within("#discount-#{@discount_3.id}") do
        expect(page).to have_content("Discount: #{@discount_3.discount_int}%")
        expect(page).to have_content("Quantity Threshold: #{@discount_3.quantity_threshold}")
      end
    end

    it "links to each discounts show page" do
      visit "/merchant/#{@merchant_1.id}/bulk_discounts"

      within("#discount-#{@discount_1.id}") do
        expect(page).to have_link(@discount_1.name)
      end
      within("#discount-#{@discount_2.id}") do
        expect(page).to have_link(@discount_2.name)
      end
      within("#discount-#{@discount_3.id}") do
        expect(page).to have_link(@discount_3.name)
      end
    end
  end
end
