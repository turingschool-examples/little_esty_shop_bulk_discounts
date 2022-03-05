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

  end
