require 'rails_helper'

RSpec.describe 'Bulk Discount Show' do
  before(:each) do
    @merchant1 = create(:merchant)

    @discount1 = create(:discount, merchant_id: @merchant1.id )
  end

  describe 'User Story 5' do
    it 'visit discount show page which shows discounts quantity threshold and percentage discount' do
      visit merchant_discount_path(@merchant1, @discount1)
      expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))
      expect(page).to have_content(@discount1.threshold)
      expect(page).to have_content(@discount1.percent_discount)
    end
  end
  describe 'User Story 6' do
    it 'has a link that allows the merchant to edit' do
      visit merchant_discount_path(@merchant1, @discount1)
      expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))
      expect(page).to have_content(@discount1.threshold)
      expect(page).to have_content(@discount1.percent_discount)
      expect(page).to have_link("Edit #{@discount1.name}")

    end
    it 'clicks edit link and takes me to edit page, with attributes pre-populated' do
      visit merchant_discount_path(@merchant1, @discount1)
      expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))

      click_on "Edit #{@discount1.name}"
      expect(current_path).to eq(edit_merchant_discount_path(@merchant1, @discount1))

      expect(page).to have_field('discount_name', with: @discount1.name)
      expect(page).to have_field('discount_quantity_threshold', with: @discount1.quantity_threshold)
      expect(page).to have_field('discount_percentage', with: @discount1.percentage)
    end
  end
end
