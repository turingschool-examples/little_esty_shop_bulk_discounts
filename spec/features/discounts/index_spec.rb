require 'rails_helper'
RSpec.describe 'Index page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @discount1 = Discount.create!(percentage_discount: 20, quantity_threshold: 5, merchant_id: @merchant1.id)
    @discount2 = Discount.create!(percentage_discount: 25, quantity_threshold: 6, merchant_id: @merchant1.id)

    visit merchant_discounts_path(@merchant1)
  end

    it "shows all of the discounts and attributes",:vcr do
      expect(page).to have_content('Discounts')

      within("#discount-#{@discount1.id}") do
        expect(page).to have_content(@discount1.percentage_discount)
        expect(page).to have_content(@discount1.quantity_threshold)
        click_on("#{@discount1.id}")
        expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))
      end
    end

    it "can show a header with the first 3 upcoming holidays",:vcr do
      holidays = HolidayFacade.create_holidays

      expect(page).to have_content("Upcoming Holidays")

      holidays.each do |holiday|
        expect(page).to have_content(holiday.name)
        expect(page).to have_content(holiday.date)
      end
    end

    it "has a link to create a new discount that takes you to a new page",:vcr do
      click_on "Create discount"

      expect(current_path).to eq(new_merchant_discount_path(@merchant1))
    end

    it "has link next to each discount to delete it",:vcr do

      within("#discount-#{@discount1.id}") do
        expect(page).to have_content(@discount1.id)
        expect(page).to have_content(@discount1.percentage_discount)
        expect(page).to have_content(@discount1.quantity_threshold)
        click_on "Delete discount #{@discount1.id}"
        expect(current_path).to eq(merchant_discounts_path(@merchant1))
      end
      expect(page).to_not have_content(@discount1.id)
    end
end
