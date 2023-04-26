require 'rails_helper'

RSpec.describe 'Bulk Discounts Index Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Body Care')
    @merchant3 = Merchant.create!(name: 'Skin Care')
    @merchant4 = Merchant.create!(name: 'Nail Care')

    @discount1 = @merchant1.bulk_discounts.create!(percentage_discount: 0.20, quantity_threshold: 10, promo_name: '20% off 10+')
    @discount2 = @merchant1.bulk_discounts.create!(percentage_discount: 0.30, quantity_threshold: 15, promo_name: '30% off 15+')
    @discount3 = @merchant1.bulk_discounts.create!(percentage_discount: 0.40, quantity_threshold: 20, promo_name: '40% off 20+')
    @discount4 = @merchant1.bulk_discounts.create!(percentage_discount: 0.50, quantity_threshold: 25, promo_name: '50% off 25+')

    visit merchant_bulk_discounts_path(@merchant1)
  end

  describe 'Bulk Index page' do
    it 'displays all bulk discounts, quantity thresholds, and percentage discounts, should also have a link to their show page, and I see a link to create a new discount' do
      within "#discount-#{@discount1.id}" do
        expect(page).to have_content(@discount1.percentage_discount * 100)
        expect(page).to have_content(@discount1.quantity_threshold)
        expect(page).to have_link(@discount1.promo_name)
      end

      within "#discount-#{@discount2.id}" do
        expect(page).to have_content(@discount2.percentage_discount * 100)
        expect(page).to have_content(@discount2.quantity_threshold)
        expect(page).to have_link(@discount2.promo_name)
        
        click_link(@discount2.promo_name)

        expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount2))
      end
    end
    
    it 'has a link to create a new discount' do
      expect(page).to have_link('New Discount')
      click_link('New Discount')

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
    end
  end
end