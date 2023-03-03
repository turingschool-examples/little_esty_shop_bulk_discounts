require 'rails_helper'

RSpec.describe 'bulk discount index page' do 
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @bulk_discount_1 = BulkDiscount.create!(percentage: 0.10, quantity_threshhold: 10, merchant: @merchant1)
    @bulk_discount_2 = BulkDiscount.create!(percentage: 0.15, quantity_threshhold: 15, merchant: @merchant1)
  end

  it 'will have a list of all discounts for that merchant' do 
    expect(page).to have_content("Discount: #{@bulk_discount_1.percentage}")
    expect(page).to have_content("Amount of items needed for discount: #{@bulk_discount_1.threshold}")
    expect(page).to have_content("Discount: #{@bulk_discount_2.percentage}")
    expect(page).to have_content("Amount of items needed for discount: #{@bulk_discount_2.threshold}")
  end
end