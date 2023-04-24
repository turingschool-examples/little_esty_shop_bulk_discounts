require 'rails_helper'

RSpec.describe 'bulk_discounts_index_page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @bd_1 = BulkDiscount.create!(percentage_discount: 20, quantity_threshold: 10, merchant_id: @merchant1.id)
    @bd_2 = BulkDiscount.create!(percentage_discount: 30, quantity_threshold: 10, merchant_id: @merchant1.id)
    @bd_3 = BulkDiscount.create!(percentage_discount: 10, quantity_threshold: 5, merchant_id: @merchant2.id)
    
    visit merchant_bulk_discounts_path(@merchant1)
  end

  it 'has a percentage discount' do
    expect(page).to have_content("Discount: 20.0%")
    expect(page).to have_no_content("Discount: 10.0%")
  end

  it 'has quantity thresholds' do
    expect(page).to have_content("Quantity: 10")
    expect(page).to have_no_content("Quantity: 5")
  end

  it 'includes a link to each bulk_discounts show page' do
    expect(page).to have_link(@bd_1.id, href: merchant_bulk_discount_path(@merchant1, @bd_1))
  end
end