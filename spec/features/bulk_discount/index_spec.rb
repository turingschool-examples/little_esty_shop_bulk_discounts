#----All Alex's code-----

require 'rails_helper'

RSpec.describe 'bulk discount index' do
  it 'shows all the discounts' do
    merchant1 = Merchant.create!(name: 'Hair Care')
    merchant2 = Merchant.create!(name: 'Cell phone')
    bd1 = merchant1.bulk_discounts.create!(percent: 30, threshold: 3)
    bd2 = merchant2.bulk_discounts.create!(percent: 50, threshold: 5)

    visit "/bulk_discounts"

    expect(page).to have_content("Current Discounts")
    expect(page).to have_content(merchant2.name)
    expect(page).to have_link("#{bd1.percent}% off")
    expect(page).to have_content(bd1.threshold)
    expect(page).to have_content(merchant1.name)
    expect(page).to have_link("#{bd2.percent}% off")
    expect(page).to have_content(bd2.threshold)

  end
end
