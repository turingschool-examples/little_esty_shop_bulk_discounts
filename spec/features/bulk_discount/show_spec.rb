#----All Alex's code-----

require 'rails_helper'

RSpec.describe 'bulk discount show' do
  it 'lists the discount and its info' do
    merchant1 = Merchant.create!(name: 'Hair Care')
    bd1 = merchant1.bulk_discounts.create!(percent: 30, threshold: 3)

    visit "/merchant/#{merchant1.id}/bulk_discounts/#{bd1.id}"

    expect(page).to have_content("Bulk Discount #{bd1.id}")

    expect(page).to have_content("#{bd1.percent}% off of #{bd1.threshold} items or more.")
  end

  it 'has link to update a discount' do
    merchant1 = Merchant.create!(name: 'Hair Care')
    bd1 = merchant1.bulk_discounts.create!(percent: 30, threshold: 3)

    visit "/merchant/#{merchant1.id}/bulk_discounts/#{bd1.id}"

    expect(page).to have_link("Update Discount")
    click_link "Update Discount"
    expect(current_path).to eq("/merchant/#{merchant1.id}/bulk_discounts/#{bd1.id}/edit")
  end
end
