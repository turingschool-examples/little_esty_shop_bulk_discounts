require 'rails_helper'

RSpec.describe 'discount show page' do
  before(:each) do
    @merchant = Merchant.create!(name: "John Sandman")
    @discount1 = @merchant.discounts.create!(percentage: 20, threshold: 10)
    @discount2 = @merchant.discounts.create!(percentage: 7, threshold: 12)

    visit merchant_discount_path(@merchant, @discount1)
  end

  it 'shows the percentage/threshold of that discount' do
    expect(page).to have_content(@discount1.percentage)
    expect(page).to have_content(@discount1.threshold)
  end
end
