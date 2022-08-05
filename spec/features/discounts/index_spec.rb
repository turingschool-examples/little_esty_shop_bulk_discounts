require 'rails_helper'

RSpec.describe 'discounts index page' do
   it 'shows all bulk discounts including percentage discount and quantity thresholds' do
      @merchant1 = Merchant.create!(name: 'Hair Care')

      @discount10 = @merchant1.discounts.create!(percentage: 10, quantity: 10)
      @discount15 = @merchant1.discounts.create!(percentage: 15, quantity: 15)

      visit merchant_discounts_path(@merchant1)

      expect(page).to have_content(@discount10.quantity)
      expect(page).to have_content(@discount10.percentage)
      save_and_open_page
   end
end