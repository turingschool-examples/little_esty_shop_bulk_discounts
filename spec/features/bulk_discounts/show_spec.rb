require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount Show Page' do
  before :each do
    test_data
    @discount1 = @merchant1.bulk_discounts.create!(percentage_discount: 0.2, quantity_threshold: 10, promo_name: 'Buy 10, Get 20% Off')
    @discount2 = @merchant1.bulk_discounts.create!(percentage_discount: 0.3, quantity_threshold: 15, promo_name: 'Rewards Program')
    @discount3 = @merchant2.bulk_discounts.create!(percentage_discount: 0.42, quantity_threshold: 20, promo_name: 'National Haircut Day')
  end

  describe 'When I visit my bulk discount show page' do
    it 'I see the bulk discount quantity threshold and percentage discount' do
      visit merchant_bulk_discount_path(@merchant1, @discount1)
      within "#discount-info" do
        expect(page).to have_content(@discount1.quantity_threshold)
        expect(page).to have_content(@discount1.percentage_discount * 100)
      end 

      visit merchant_bulk_discount_path(@merchant1, @discount2)
      within "#discount-info" do
        expect(page).to have_content(@discount2.quantity_threshold)
        expect(page).to have_content(@discount2.percentage_discount * 100)
      end

      visit merchant_bulk_discount_path(@merchant2, @discount3)
      within "#discount-info" do
        expect(page).to have_content(@discount3.quantity_threshold)
        expect(page).to have_content(@discount3.percentage_discount * 100)
      end
    end

    it 'I see a link to edit the bulk discount' do
      visit merchant_bulk_discount_path(@merchant1, @discount1)
      expect(page).to have_button("Edit Discount")
      click_button("Edit Discount")
      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1))
    end
  end
end