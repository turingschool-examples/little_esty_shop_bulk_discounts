require 'rails_helper'

RSpec.describe 'Merchant Bulk Discounts Index' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Hair Care')
    @discount_1 = BulkDiscount.create!(name:"small discount", percentage_discount: 0.10, quantity_threshold: 10, merchant_id: @merchant_1.id)
    @discount_2 = BulkDiscount.create!(name:"medium discount", percentage_discount: 0.15, quantity_threshold: 14, merchant_id: @merchant_1.id)
    @discount_3 = BulkDiscount.create!(name:"huge discount", percentage_discount: 0.20, quantity_threshold: 20, merchant_id: @merchant_1.id)
    @holidays = HolidayService.get_holidays

  end

  describe "As a merchant" do
    it "I see a section with a header of 'Upcoming Holidays'" do
      visit "/merchant/#{@merchant_1.id}/dashboard"

      expect(page).to have_content('Upcoming Holidays')
      within("#holiday-#{@holidays.first.date}") do
        expect(page).to have_content(@holidays.first.name)
        expect(page).to have_content(@holidays.first.date)
      end
      within("#holiday-#{@holidays[1].date}") do
        expect(page).to have_content(@holidays[1].name)
        expect(page).to have_content(@holidays[1].date)
      end
      within("#holiday-#{@holidays.last.date}") do
        expect(page).to have_content(@holidays.last.name)
        expect(page).to have_content(@holidays.last.date)
      end
    end
  end
end
