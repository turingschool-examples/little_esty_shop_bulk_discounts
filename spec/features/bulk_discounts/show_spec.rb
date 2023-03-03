require 'rails_helper'

describe "merchant bulk discount show page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @discount1 = BulkDiscount.create!(percentage_discount: 0.25, quantity_threshold: 50, merchant_id: @merchant1.id)

  end

  it "I see the bulk discount's quanity threshold and percentage discount" do
    visit merchant_bulk_discount_path(@merchant1, @discount1)
  
    expect(page).to have_content("Bulk Discount: #{@discount1.id}")
    expect(page).to have_content("Percentage discount: 25%")
    expect(page).to have_content("Quantity threshold: #{@discount1.quantity_threshold}")
  end
end