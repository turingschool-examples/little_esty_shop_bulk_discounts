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
      save_and_open_page
      expect(page).to have_content("#{@merchant1.name} Bulk Discount ID: 1 Show Page")
      expect(page).to have_content("Percentage Discount: #{@bulk_discount_1.percentage_discount}")
      expect(page).to have_content("Quantity Threshold: #{@bulk_discount_1.quantity_threshold}")
      
      expect(page).to_not have_content("Percentage Discount: #{@bulk_discount_2.percentage_discount}")
      expect(page).to_not have_content("Quantity ThresholdL #{@bulk_discount_2.quantity_threshold}")
    end
  end
end
