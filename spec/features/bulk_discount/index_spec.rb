#----All Alex's code-----

require 'rails_helper'

RSpec.describe 'bulk discount index' do
  it 'shows all the discounts' do
    merchant1 = Merchant.create!(name: 'Hair Care')
    bd1 = merchant1.bulk_discounts.create!(percent: 30, threshold: 3)
    bd2 = merchant1.bulk_discounts.create!(percent: 50, threshold: 5)

    visit "/merchant/#{merchant1.id}/bulk_discounts"

    expect(page).to have_content("Current Discounts")
    expect(page).to have_link("#{bd1.percent}% off")
    expect(page).to have_content(bd1.threshold)
    expect(page).to have_link("#{bd2.percent}% off")
    expect(page).to have_content(bd2.threshold)
  end

  it 'creates a new discount' do
    merchant1 = Merchant.create!(name: 'Hair Care')
    merchant2 = Merchant.create!(name: 'Cell phone')
    bd1 = merchant1.bulk_discounts.create!(percent: 30, threshold: 3)
    bd2 = merchant1.bulk_discounts.create!(percent: 50, threshold: 5)

    visit "/merchant/#{merchant1.id}/bulk_discounts"

    expect(page).to have_link("Create New Discount")
    click_link("Create New Discount")
    expect(current_path).to eq("/merchant/#{merchant1.id}/bulk_discounts/new")
    fill_in "percent", with: 20
    fill_in "threshold", with: 20
    click_button "Save"
    expect(current_path).to eq("/merchant/#{merchant1.id}/bulk_discounts")
    expect(page).to have_content("You get 20% off if you buy 20 or more!")
  end

  it 'deletes a discount' do
    merchant1 = Merchant.create!(name: 'Hair Care')
    bd1 = merchant1.bulk_discounts.create!(percent: 30, threshold: 3)
    bd2 = merchant1.bulk_discounts.create!(percent: 50, threshold: 5)

    visit "/merchant/#{merchant1.id}/bulk_discounts"

    expect(page).to have_button("Delete Discount #{bd1.id}")
    click_button("Delete Discount #{bd1.id}")
    expect(current_path).to eq("/merchant/#{merchant1.id}/bulk_discounts")
    expect(page).to_not have_content("You get #{bd1.percent}% off if you buy #{bd1.threshold} or more!")
  end

  it 'has holiday info' do
    merchant1 = Merchant.create!(name: 'Hair Care')
    bd1 = merchant1.bulk_discounts.create!(percent: 30, threshold: 3)
    bd2 = merchant1.bulk_discounts.create!(percent: 50, threshold: 5)
    
    visit "/merchant/#{merchant1.id}/bulk_discounts"

    expect(page).to have_content("Upcomming Holidays")
    expect(page).to have_content("Independence Day 2021-07-05")
    expect(page).to have_content("Labor Day 2021-09-06")
    expect(page).to have_content("Columbus Day 2021-10-11")
  end
end
