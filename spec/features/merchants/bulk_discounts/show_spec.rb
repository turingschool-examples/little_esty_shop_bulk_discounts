require 'rails_helper'

RSpec.describe 'Bulk discounts Show Page' do
  it 'displays discounts quantity threshold and percentage discount ' do
      merchant = Merchant.create!(name: 'Hair Care')

      discount_1 = merchant.bulk_discounts.create!(discount: 0.20, quantity: 10)
      discount_2 = merchant.bulk_discounts.create!(discount: 0.30, quantity: 15)

      visit "/merchant/#{merchant.id}/bulk_discounts/#{discount_1.id}"
      expect(page).to have_content(discount_1.discount)
      expect(page).to have_content(discount_1.quantity)

    end

#     Merchant Bulk Discount Edit
#
# As a merchant
# When I visit my bulk discount show page
# Then I see a link to edit the bulk discount
# When I click this link
# Then I am taken to a new page with a form to edit the discount
# And I see that the discounts current attributes are pre-poluated in the form
# When I change any/all of the information and click submit
# Then I am redirected to the bulk discount's show page
# And I see that the discount's attributes have been updated

it 'half passing us  6 ' do
    merchant = Merchant.create!(name: 'Hair Care')

    discount_1 = merchant.bulk_discounts.create!(discount: 0.20, quantity: 10)
    discount_2 = merchant.bulk_discounts.create!(discount: 0.30, quantity: 15)

    visit "/merchant/#{merchant.id}/bulk_discounts/#{discount_1.id}"

    expect(page).to have_link('Edit Discount')
    click_link('Edit Discount')
    expect(current_path).to eq("/merchant/#{merchant.id}/bulk_discounts/#{discount_1.id}/edit")

    fill_in('Discount', with: '0.15')
    fill_in('Quantity', with: '5')
    click_on('Edit Discount')

    expect(current_path).to eq("/merchant/#{merchant.id}/bulk_discounts/#{discount_1.id}")

    expect(page).to have_content('Percentage Discount: 0.15')
    expect(page).to have_content('Quantity Threshold: 5')
    expect(page).to_not have_content('Percentage Discount: 0.20')
    expect(page).to_not have_content('Quantity threshold: 10')
  end
end
