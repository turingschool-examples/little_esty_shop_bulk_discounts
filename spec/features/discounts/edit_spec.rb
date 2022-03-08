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
      click_on "Edit Discount"
      expect(current_path).to eq(edit_merchant_discount_path(@merchant1, @discount1))

      expect(page).to have_field('name', with: @discount1.name)
      expect(page).to have_field('threshold', with: @discount1.threshold)
      expect(page).to have_field('percent_discount', with: @discount1.percent_discount)
    end

    it 'changes information, clicks submit and redirecteds to show page with changes present' do
      visit edit_merchant_discount_path(@merchant1, @discount1)
      expect(current_path).to eq(edit_merchant_discount_path(@merchant1, @discount1))

      fill_in "name", with: "Test 2"
      click_on "Save"
      expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))

      expect(page).to have_content("Discount Has Been Updated!")
      expect(page).to have_content("Test 2")
      expect(page).to_not have_content(@discount1.name)
    end
    it 'gives error if field is not filled in correctly' do
      visit edit_merchant_discount_path(@merchant1, @discount1)
      expect(current_path).to eq(edit_merchant_discount_path(@merchant1, @discount1))

      fill_in "name", with: ""
      fill_in "threshold", with: ""
      fill_in "percent_discount", with: ""
      click_on "Save"

      expect(current_path).to eq(edit_merchant_discount_path(@merchant1, @discount1))
      expect(page).to have_content("Error: Percent discount can't be blank")

      within 'div.header' do
        expect(page).to have_content(@merchant1.name)
      end
    end
  end
end
