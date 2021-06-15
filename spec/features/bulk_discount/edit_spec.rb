#----All Alex's code-----

require 'rails_helper'

RSpec.describe 'bulk discount edit and update' do
  it 'can update a discount' do
    merchant1 = Merchant.create!(name: 'Hair Care')
    bd1 = merchant1.bulk_discounts.create!(percent: 30, threshold: 3)

    visit "/merchant/#{merchant1.id}/bulk_discounts/#{bd1.id}/edit"
    expect(page).to have_field("percent", with: "30")
    expect(page).to have_field("Threshold", with: "3")
    fill_in "percent", with: 40
    fill_in "threshold", with: 4
    click_button "Save"
    expect(current_path).to eq("/merchant/#{merchant1.id}/bulk_discounts/#{bd1.id}")
    expect(page).to have_content(40)
    expect(page).to have_content(4)
  end
end
