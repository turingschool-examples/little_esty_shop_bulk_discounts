require 'rails_helper'

RSpec.describe 'bulk discounts show', type: :feature do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @bulk_discount_1 = BulkDiscount.create!(percentage_discount: 10, quantity_threshold: 10, merchant_id: @merchant1.id)
    @bulk_discount_2 = BulkDiscount.create!(percentage_discount: 25, quantity_threshold: 15, merchant_id: @merchant1.id)

    visit merchant_bulk_discount_path(@merchant1, @bulk_discount_1)
  end

  describe 'User Story 3 (Bulk Item Show Page)' do
    it 'I see the bulk discount quantity threshold and percentage discount' do
      expect(page).to have_content("#{@merchant1.name} Bulk Discount ID: #{@bulk_discount_1.id} Show Page")
      expect(page).to have_content("Percentage Discount: #{@bulk_discount_1.percentage_discount}")
      expect(page).to have_content("Quantity Threshold: #{@bulk_discount_1.quantity_threshold}")

      expect(page).to_not have_content("Percentage Discount: #{@bulk_discount_2.percentage_discount}")
      expect(page).to_not have_content("Quantity Threshold: #{@bulk_discount_2.quantity_threshold}")
    end
  end

  describe 'User Story 4 (Bulk Item Edit Page)' do
    it 'when I visis my discount show page I see a link to edit the discount' do
      expect(page).to have_link("Edit Discount")
    end

    it 'when I click this link I am taken to a new page to edit the discount' do
      click_link "Edit Discount"

      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @bulk_discount_1))
    end
  end
end
