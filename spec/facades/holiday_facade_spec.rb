require 'rails_helper'

RSpec.describe HolidayFacade do
  it "returns three Holiday POROs" do
    holidays = HolidayFacade.next_3_upcoming_holidays

    holidays.each do |holiday|
      expect(holiday).to be_a(Holiday)
    end
  end
end