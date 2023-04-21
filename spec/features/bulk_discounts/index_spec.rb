require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount Index Page' do
  before :each do
    test_data
    @discount1 = @merchant1.bulk_discounts.create!(percentage_discount: 0.2, quantity_threshold: 10, promo_name: 'Buy 10, Get 20% Off')
    @discount2 = @merchant1.bulk_discounts.create!(percentage_discount: 0.3, quantity_threshold: 15, promo_name: 'Rewards Program')
    @discount3 = @merchant2.bulk_discounts.create!(percentage_discount: 0.42, quantity_threshold: 20, promo_name: 'National Haircut Day')
    visit merchant_bulk_discounts_path(@merchant1)
  end

  describe 'When I visit my bulk discount index page' do
    it 'I see all of my bulk discounts including their percentage discount, quantity thresholds and a link to their show page' do
   
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

    it 'I see a link to create a new discount' do
      expect(page).to have_link("New Discount")

      click_link("New Discount")

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
    end

    it 'I see a link to delete each discount next to the discount' do
      within "#discount-#{@discount1.id}" do
        expect(page).to have_link("Delete Discount")
      end
      within "#discount-#{@discount2.id}" do
        expect(page).to have_link("Delete Discount")
        click_link("Delete Discount")
      end

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
      expect(page).to_not have_content(@discount2.promo_name)
      expect(page).to have_content(@discount1.promo_name)
    end
  end
end