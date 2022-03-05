require 'rails_helper'

RSpec.describe 'Bulk discounts Index Page' do
  it 'displays link to view all my discounts' do
      merchant = Merchant.create!(name: 'Hair Care')

      discount_1 = merchant.bulk_discounts.create!(discount: 0.20, quantity: 10)
      discount_2 = merchant.bulk_discounts.create!(discount: 0.30, quantity: 15)

      visit "/merchant/#{merchant.id}/bulk_discounts"
      expect(page).to have_content(discount_1.discount)
      expect(page).to have_content(discount_1.quantity)
      expect(page).to have_content(discount_2.discount)
      expect(page).to have_content(discount_2.quantity)

  end

  it 'displays link to view all my discounts' do
      merchant = Merchant.create!(name: 'Hair Care')

      discount_1 = merchant.bulk_discounts.create!(discount: 0.20, quantity: 10)
      discount_2 = merchant.bulk_discounts.create!(discount: 0.30, quantity: 15)

      visit "/merchant/#{merchant.id}/bulk_discounts"

      within("#discount-#{discount_1.id}") do

      expect(page).to have_link('Discount')
      click_on('Discount')
      end

      expect(current_path).to eq("/merchant/#{merchant.id}/bulk_discounts/#{discount_1.id}")

  end

  it 'displays link to create a new discount' do
      merchant = Merchant.create!(name: 'Hair Care')

      discount_1 = merchant.bulk_discounts.create!(discount: 0.20, quantity: 10)
      discount_2 = merchant.bulk_discounts.create!(discount: 0.30, quantity: 15)

    visit "merchant/#{merchant.id}/bulk_discounts"
    expect(page).to have_link('Create Discount')

    click_link('Create Discount')

  end

  it 'displays link to create a new discount' do
      merchant = Merchant.create!(name: 'Hair Care')

      discount_1 = merchant.bulk_discounts.create!(discount: 0.20, quantity: 10)
      discount_2 = merchant.bulk_discounts.create!(discount: 0.30, quantity: 15)

    visit "merchant/#{merchant.id}/bulk_discounts"

    click_link('Create Discount')
    expect(page).to have_current_path("/merchant/#{merchant.id}/bulk_discounts/new")
  
    fill_in('Discount', with: '0.30')
    fill_in('Quantity', with: '10')
    click_on('commit')

    expect(page).to have_current_path("/merchant/#{merchant.id}/bulk_discounts")
    expect(page).to have_content('0.3')
    expect(page).to have_content('10')
  end

end
