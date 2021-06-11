#----All Alex's code-----

require 'rails_helper'

RSpec.describe 'bulk discount show' do
  it 'shows ' do
    merchant1 = Merchant.create!(name: 'Hair Care')
    bd1 = merchant1.bulk_discounts.create!(percent: 30, threshold: 3)

    visit "/bulk_discounts/#{bd1.id}"

    expect(page).to have_content("Bulk Discount #{bd1.id}")
    
    expect(page).to have_content("#{bd1.percent}% off of #{bd1.threshold} items or more.")
  end
end
