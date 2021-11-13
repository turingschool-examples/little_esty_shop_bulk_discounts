require 'rails_helper'

RSpec.describe 'index page' do
#   As a merchant
# When I visit the discounts index page
# I see a section with a header of "Upcoming Holidays"
# In this section the name and date of the next 3 upcoming US holidays are listed.
#
# Use the Next Public Holidays Endpoint in the [Nager.Date API](https://date.nager.at/swagger/index.html)
  it "can show a header with the first 3 upcoming holidays",:vcr do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    holidays = HolidayFacade.create_holidays

    visit merchant_discounts_path(@merchant1)

    expect(page).to have_content("Upcoming Holidays")

    holidays.each do |holiday|
      expect(page).to have_content(holiday.name)
      expect(page).to have_content(holiday.date)
    end
  end
end
