require 'rails_helper'

RSpec.describe 'Merchants Bulk Discount Show Page' do
  before(:each) do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @bd1 = @merchant1.bulk_discounts.create!(threshold: 10, discount: 10)
    @bd2 = @merchant1.bulk_discounts.create!(threshold: 15, discount: 15)
    @bd3 = @merchant1.bulk_discounts.create!(threshold: 20, discount: 20)
  end

  context 'when I visit a merchants bulk discount index page' do
    it 'shows the bulk discounts discount and threshold' do
      visit "/merchant/#{@merchant1.id}/bulk_discounts/#{@bd1.id}"
      expect(page).to have_content("Discount: #{@bd1.discount}%")
      expect(page).to have_content("Threshold: #{@bd1.threshold} Items")
    end
  end
end
