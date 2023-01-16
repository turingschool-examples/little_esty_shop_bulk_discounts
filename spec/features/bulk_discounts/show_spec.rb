require 'rails_helper'
# 4: Merchant Bulk Discount Show

# As a merchant
# When I visit my bulk discount show page
# Then I see the bulk discount's quantity threshold and percentage discount

RSpec.describe 'bulk discount show page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Sallie Mae')
    @discount1a = @merchant1.bulk_discounts.create!(percentage_discount: 0.20, quantity_threshold: 10)
    visit merchant_bulk_discount_path(@merchant1, @discount1a)
  end
  it 'shows the bulk discounts quantity threshold and percentage discount' do
    expect(page).to have_content("#{@merchant1.name}'s Bulk Discount-#{@discount1a.id} Show Page")
    expect(page).to have_content("Percentage Discount: #{@discount1a.sanitized_percentage}%")
    expect(page).to have_content("Quantity Threshold: #{@discount1a.quantity_threshold}")
  end
end