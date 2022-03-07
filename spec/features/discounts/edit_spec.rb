require 'rails_helper'

RSpec.describe 'Bulk Discount Edit' do
  before(:each) do
    @merchant1 = create(:merchant)

    @discount1 = create(:discount, merchant_id: @merchant1.id )
  end

  describe 'User Story 6' do
    it 'clicks edit link and takes me to edit page, with attributes pre-populated' do
      visit merchant_discount_path(@merchant1, @discount1)
      expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))

      click_on "Edit #{@discount1.name}"
      expect(current_path).to eq(edit_merchant_discount_path(@merchant1, @discount1))

      expect(page).to have_field('discount_name', with: @discount1.name)
      expect(page).to have_field('discount_quantity_threshold', with: @discount1.quantity_threshold)
      expect(page).to have_field('discount_percentage', with: @discount1.percentage)
    end

    it 'changes information, clicks submit and redirecteds to show page with changes present' do
      visit edit_merchant_discount_path(@merchant1, @discount1)
      expect(current_path).to eq(edit_merchant_discount_path(@merchant1, @discount1))

      fill_in "discount_name", with: "Test 2"
      click_on "Edit #{@discount1.name} Discount"
      expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))

      expect(page).to have_content("Test 2 Has Been Updated!")
      expect(page).to have_content("Test 2")
      expect(page).to_not have_content(@discount1.name)
    end
    it 'gives error if field is not filled in correctly' do
      visit edit_merchant_discount_path(@merchant1, @discount1)
      expect(current_path).to eq(edit_merchant_discount_path(@merchant1, @discount1))

      fill_in "discount_name", with: ""
      fill_in "discount_quantity_threshold", with: ""
      fill_in "discount_percentage", with: ""
      click_on "Edit #{@discount1.name} Discount"
      expect(current_path).to eq(edit_merchant_discount_path(@merchant1, @discount1))

      expect(page).to have_content("Error: Name can't be blank, Quantity threshold can't be blank, Percentage can't be blank")
      expect(page).to have_content(@discount1.name)
    end
  end
end
