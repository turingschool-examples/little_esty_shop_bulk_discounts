require 'rails_helper'

RSpec.describe 'bulk discount index' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @discount_1 = BulkDiscount.create!(percent_discount: 10, quantity_threshold: 10, merchant_id: @merchant1.id )
    @discount_2 = BulkDiscount.create!(percent_discount: 20, quantity_threshold: 12, merchant_id: @merchant1.id )
    @discount_3 = BulkDiscount.create!(percent_discount: 30, quantity_threshold: 15, merchant_id: @merchant1.id )

    visit merchant_bulk_discounts_path(@merchant1)
  end

  it "shows bulk discounts and attributes" do
    visit merchant_bulk_discounts_path(@merchant1)

    within("#discount-index-#{@merchant1.id}") do
      expect(page).to have_content("Discounts")
      expect(page).to have_content("Percent Discount: #{@discount_1.percent_discount}")
      expect(page).to have_content("Quantity Threshold: #{@discount_1.quantity_threshold}")
      expect(page).to have_link("Discount #{@discount_1}")
    end
  end
end
