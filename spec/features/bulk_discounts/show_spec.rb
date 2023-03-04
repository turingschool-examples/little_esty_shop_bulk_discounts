require 'rails_helper'

RSpec.describe "Bulk Discount Show Page" do 
  before :each do 
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @bulk_discount_1 = BulkDiscount.create!(percentage: 0.10, quantity_threshhold: 10, merchant: @merchant1)
  
    visit merchant_bulk_discount_path(@merchant1, @bulk_discount_1)
  end

  it 'will list the bulk discounts quantity threshhold and percentage discount' do 

    expect(page).to have_content("percentage: #{@bulk_discount_1.percentage}")
    expect(page).to have_content("quantity threshhold: #{@bulk_discount_1.quantity_threshhold}")
  end
end