require 'rails_helper'

RSpec.describe HolidayFacade do
  let(:holidays) { HolidayFacade.country_holidays("US") }

  it 'creates a list of holiday objects', :vcr do 
    expect(holidays).to be_an(Array)

    holidays.each do |holiday|
      expect(holiday).to be_a(Holiday)
      expect(holiday.date).to be_a(String)
      expect(holiday.name).to be_a(String)
    end
  end
end