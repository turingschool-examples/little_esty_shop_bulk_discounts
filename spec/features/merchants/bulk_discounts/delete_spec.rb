require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount delete' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Hair Care')
    @discount_1 = BulkDiscount.create!(name:"small discount", percentage_discount: 0.09, quantity_threshold: 9, merchant_id: @merchant_1.id)
    @discount_2 = BulkDiscount.create!(name:"medium discount", percentage_discount: 0.15, quantity_threshold: 14, merchant_id: @merchant_1.id)
    @discount_3 = BulkDiscount.create!(name:"huge discount", percentage_discount: 0.2, quantity_threshold: 20, merchant_id: @merchant_1.id)
  end

  describe "When I visit my bulk bulk_discounts index" do
    it "Then next to each bulk discount I see a link to delete it" do
      visit "/merchant/#{@merchant_1.id}/bulk_discounts"

      within("#discount-#{@discount_1.id}") do
        expect(page).to have_button("delete discount")
      end
      within("#discount-#{@discount_2.id}") do
        expect(page).to have_button("delete discount")
      end
      within("#discount-#{@discount_3.id}") do
        expect(page).to have_button("delete discount")
      end
    end

    it "When I click this link Then I am redirected back to the bulk discounts index page And I no longer see the discount listed" do
       visit "/merchant/#{@merchant_1.id}/bulk_discounts"

       within("#discount-#{@discount_1.id}") do
         expect(page).to have_button("delete discount")
         click_button("delete discount")
       end
       expect(current_path).to eq("/merchant/#{@merchant_1.id}/bulk_discounts")
       expect(page).to have_no_content(@discount_1.name)
       expect(page).to have_no_content(@discount_1.discount_int)
       expect(page).to have_no_content(@discount_1.quantity_threshold)
    end
  end
end
