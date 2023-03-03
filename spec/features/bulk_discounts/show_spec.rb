require 'rails_helper'

RSpec.describe 'bulk_discount show' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')
  
    @bulk_discount1 = @merchant1.bulk_discounts.create!(percentage: 10, threshold: 15)
    @bulk_discount2 = @merchant1.bulk_discounts.create!(percentage: 15, threshold: 25)
    @bulk_discount3 = @merchant1.bulk_discounts.create!(percentage: 25, threshold: 30)
    @bulk_discount4 = @merchant2.bulk_discounts.create!(percentage: 50, threshold: 2)
  end 

  it 'shows all bulk discounts with percentages and thresholds' do
    visit merchant_bulk_discount_path(@merchant1, @bulk_discount1)
    
    expect(page).to have_content("You can get #{@bulk_discount1.percentage}% off")
    expect(page).to have_content("if you buy #{@bulk_discount1.threshold} or more items.")

    visit merchant_bulk_discount_path(@merchant2, @bulk_discount2)

    expect(page).to have_content("You can get #{@bulk_discount2.percentage}% off")
    expect(page).to have_content("if you buy #{@bulk_discount2.threshold} or more items.")
    expect(page).to_not have_content("You can get #{@bulk_discount1.percentage}% off")
  end
end