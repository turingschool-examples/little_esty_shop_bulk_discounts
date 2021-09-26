require 'rails_helper'

RSpec.describe 'discount index page' do
  before(:each) do
    @merchant = Merchant.create!(name: "John Sandman")
    @discount1 = @merchant.discounts.create!(percentage: 20, threshold: 10)
    @discount2 = @merchant.discounts.create!(percentage: 7, threshold: 12)
    visit merchant_discounts_path(@merchant)
  end

  it 'shows all discounts with their info' do
    expect(page).to have_content(@discount1.percentage)
    expect(page).to have_content(@discount1.threshold)
    expect(page).to have_content(@discount2.percentage)
    expect(page).to have_content(@discount2.threshold)
  end

  it 'has a link to each discounts show page' do
    click_link(@discount1.percentage)

    expect(current_path).to eq(merchant_discount_path(@merchant, @discount1))
  end
end
