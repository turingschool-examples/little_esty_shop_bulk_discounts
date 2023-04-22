require 'rails_helper'

RSpec.describe 'Bulk Discount Edit', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Hair Care')

    @bulk_item_1 = BulkDiscount.create!(percentage_discount: 10, quantity_threshold: 15, merchant_id: @merchant_1.id)

    visit edit_merchant_bulk_discount_path(@merchant_1, @bulk_item_1)
  end

  describe 'User Story 4 (Edit Action)' do
    it 'has a form to edit an bulk discount, prefilled with the current details' do
      within "#edit-form" do
        expect(page).to have_field(:percentage_discount)
        expect(find_field(:percentage_discount).value).to eq(@bulk_item_1.percentage_discount.to_s)

        expect(page).to have_field(:quantity_threshold)
        expect(find_field(:quantity_threshold).value).to eq(@bulk_item_1.quantity_threshold.to_s)
      end
    end

    it 'when I fill in the form with invalid data, I am redirected back to the edit form' do
      fill_in :percentage_discount, with: -5
      fill_in :quantity_threshold, with: -10

      click_button "Edit Discount"

      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant_1, @bulk_item_1))
      expect(page).to have_content("Discount not updated, please try again.")
      expect(find_field(:percentage_discount).value).to eq(@bulk_item_1.percentage_discount.to_s)
      expect(find_field(:quantity_threshold).value).to eq(@bulk_item_1.quantity_threshold.to_s)
    end

    xit 'when filled with partial data, I am redirected back to the bulk discount show page, where I see the updated data' do
      fill_in :percentage_discount, with: 30

      click_button "Edit Discount"

      expect(current_path).to eq(visit merchant_bulk_discount_path(@merchant1, @bulk_discount_1))
      expect(page).to have_content("Percentage Discount: 30")
      expect(page).to_not have_content("Percentage Discount: 10")
      expect(page).to have_content("Quantity Threshold: 15")
    end

    xit 'when filled out with all data, I am redirected back to the bulk discount show page, where I see the updated data' do
      fill_in :percentage_discount, with: 30
      fill_in :quantity_threshold, with: 40

      click_button "Edit Discount"

      expect(current_path).to eq(visit merchant_bulk_discount_path(@merchant1, @bulk_discount_1))
      expect(page).to have_content("Percentage Discount: 30")
      expect(page).to_not have_content("Percentage Discount: 10")
      expect(page).to have_content("Quantity Threshold: 40")
      expect(page).to_not have_content("Quantity Threshold: 15")
    end
  end
end