require 'rails_helper'

RSpec.describe 'Bulk Discount New', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Hair Care')

    visit new_merchant_bulk_discount_path(@merchant_1)
  end

  describe 'User Story 2' do
    it 'has a form to create a new bulk discount' do
      expect(page).to have_field(:percentage_discount)
      expect(page).to have_field(:quantity_threshold)
    end

    it 'when I fill in the form with invalid data, I am redirected back to the new form' do
      fill_in :percentage_discount, with: -5
      fill_in :quantity_threshold, with: -10

      click_button "Create Discount"

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1))
      expect(page).to have_content("Discount not created, please try again.")
    end

    it 'when I fill in the form with valid data, I am redirected back to the bulk discounts index page, and I see my new discount' do
      fill_in :percentage_discount, with: 30
      fill_in :quantity_threshold, with: 40

      click_button "Create Discount"

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))
      
      new_discount = BulkDiscount.last

      within "#bulk-discount-#{new_discount.id}" do
        expect(page).to have_content(new_discount.percentage_discount)
        expect(page).to have_content(new_discount.quantity_threshold)
      end
    end
  end
end