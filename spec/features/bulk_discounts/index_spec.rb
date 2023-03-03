require 'rails_helper'

RSpec.describe 'bulk discounts index page' do
  before :each do 
    @merchant = Merchant.create!(name: 'Hair Care')
    @bulk_discount_1 = @merchant.bulk_discounts.create!(name: "20% off of 10", percentage_discount: 0.20, quantity_threshold: 10)
    @bulk_discount_2 = @merchant.bulk_discounts.create!(name: "30% off of 20", percentage_discount: 0.30, quantity_threshold: 20)

    visit merchant_bulk_discounts_path(@merchant)
  end
  describe 'as a merchant' do
    context 'when I visit my bulk discounts index page' do
      it 'displays a list of all of my bulk discounts including their percentage discount and quantity thresholds' do
        expect(page).to have_content(@bulk_discount_1.percentage_discount)
        expect(page).to have_content(@bulk_discount_1.quantity_threshold)
        expect(page).to have_content(@bulk_discount_2.percentage_discount)
        expect(page).to have_content(@bulk_discount_2.quantity_threshold)
      end

      it 'each bulk discount listed includes a link to its show page' do
        expect(page).to have_link('20% off of 10')
        expect(page).to have_link('30% off of 20')
      end

      it 'displays a link to create a new bulk discount' do
        expect(page).to have_link('New Bulk Discount')
      end
    end
  end
end