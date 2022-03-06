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
save_and_open_page
      expect(page).to have_content(@discount1.threshold)
      expect(page).to have_content(@discount1.percent_discount)
    end
  end
end
