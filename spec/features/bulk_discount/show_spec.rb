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

  it 'can update a discount' do
    merchant1 = Merchant.create!(name: 'Hair Care')
    bd1 = merchant1.bulk_discounts.create!(percent: 30, threshold: 3)

    expect(page).to have_button("Update Discount")
    click_button "Update Discount"
    expect(current_path).to eq("/merchant/#{merchant1.id}/bulk_discounts/#{bd.id}/edit")
    expect(page).to have_content(30)
    expect(page).to have_content(3)
    fill_out "percent", with: 40
    fill_out "threshold", with: 4
    click_button "Update"
    expect(current_path).to eq("/merchant/#{merchant1.id}/bulk_discounts/#{bd.id}")
    expect(page).to have_content(40)
    expect(page).to have_content(4)
  end
end
