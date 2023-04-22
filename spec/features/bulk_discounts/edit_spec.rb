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

  # And I see that the discounts current attributes are pre-poluated in the form
  # When I change any/all of the information and click submit
  # Then I am redirected to the bulk discount's show page
  # And I see that the discount's attributes have been updated

    it 'when I fill in the form with invalid data, I am redirected back to the edit form' do
      fill_in :percentage_discount, with: -5
      fill_in :quantity_threshold, with: -10

      click_button "Edit Discount"
    end
  end
end