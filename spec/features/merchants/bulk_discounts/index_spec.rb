require 'rails_helper'

RSpec.describe 'Merchant Bulk Discounts Index' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Hair Care')
    @discount_1 = create!(name:"small discount", percentage_discount: 10, quantity_threshold: 10, merchant_id: @merchant1)
    @discount_2 = create!(name:"medium discount", percentage_discount: 15, quantity_threshold: 14, merchant_id: @merchant1)
    @discount_3 = create!(name:"huige discount", percentage_discount: 20, quantity_threshold: 20, merchant_id: @merchant1)

  end

  describe "As a merchant" do
    it "When I visit my merchant dashboard i see a link to view all my discounts" do
      visit "/merchant/#{@merchant_1.id/dashboard}"

      expect(current_page).to have_link("my discounts")
    end

    it "When I click this link then I am taken to my bulk discounts index page" do
      visit "/merchant/#{@merchant_1.id/dashboard}"

      expect(current_page).to have_link("my discounts")
      click_link("my discounts")
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/discounts")
    end

    it "I see all of my bulk discounts including their percentage discount and quantity thresholds" do
      visit "/merchants/#{@merchant_1.id}/discounts"

      within("#discount-#{@discount_1.id}") do
        expect(current_page).to have_content("Discount: #{@merchant_1.percentage_discount}%")
        expect(current_page).to have_content("Quantity Threshold: #{@merchant_1.qauntity_threshold}")
      end
      within("#discount-#{@discount_2.id}") do
        expect(current_page).to have_content("Discount: #{@merchant_2.percentage_discount}%")
        expect(current_page).to have_content("Quantity Threshold: #{@merchant_2.qauntity_threshold}")
      end
      within("#discount-#{@discount_3.id}") do
        expect(current_page).to have_content("Discount: #{@merchant_3.percentage_discount}%")
        expect(current_page).to have_content("Quantity Threshold: #{@merchant_3.qauntity_threshold}")
      end
    end

    it "links to each discounts show page" do
      visit "/merchants/#{@merchant_1.id}/discounts"

      within("#discount-#{@discount_1.id}") do
        expect(current_page).to have_link("Discount: #{@merchant_1.percentage_discount}%")
      end
      within("#discount-#{@discount_2.id}") do
        expect(current_page).to have_link("Discount: #{@merchant_1.percentage_discount}%")
      end
      within("#discount-#{@discount_3.id}") do
        expect(current_page).to have_link("Discount: #{@merchant_1.percentage_discount}%")
      end
    end
  end
end
