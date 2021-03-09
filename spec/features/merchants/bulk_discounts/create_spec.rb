require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount Create' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Hair Care')
    @discount_1 = BulkDiscount.create!(name:"small discount", percentage_discount: 10, quantity_threshold: 10, merchant_id: @merchant_1.id)
    @discount_2 = BulkDiscount.create!(name:"medium discount", percentage_discount: 15, quantity_threshold: 14, merchant_id: @merchant_1.id)
    @discount_3 = BulkDiscount.create!(name:"huge discount", percentage_discount: 20, quantity_threshold: 20, merchant_id: @merchant_1.id)
    @discount_4 = create(:bulk_discount, merchant_id: @merchant_1.id)
  end

  describe "When I visit my bulk bulk_discounts index" do
    it "Then I see a link to create a new discount" do
      visit "/merchant/#{@merchant_1.id}/bulk_discounts"

      expect(page).to have_link("new discount")
    end

    it "When I click this link Then I am taken to a new page where I see a form to add a new bulk discount" do
       visit "/merchant/#{@merchant_1.id}/bulk_discounts"

       click_link("new discount")
       expect(current_path).to eq("/merchant/#{@merchant_1.id}/bulk_discounts/new")
    end

    it "When I fill in the form with valid data and i click submit and I am redirected back to the bulk discount index" do
      visit "/merchant/#{@merchant_1.id}/bulk_discounts/new"

      fill_in :name, :with => "New Bulk Discount"
      fill_in :percentage_discount, :with => 13
      fill_in :quantity_threshold, :with => 8
      click_button('Submit')
      expect(current_path).to eq("/merchant/#{@merchant_1.id}/bulk_discounts")
      expect(page).to have_content('New Bulk Discount')
      expect(page).to have_content(13)
      expect(page).to have_content(8)
    end
  end
end
