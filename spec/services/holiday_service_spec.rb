require 'rails_helper'

RSpec.describe HolidayService do
  it 'returns the upcoming US holidays' do
    holidays = HolidayService.get_holidays

    expect(holidays).to be_a(Array)
  end
  
  it 'returns the next three upcoming US holidays' do
    three_holidays = HolidayService.get_next_three_holidays

    expect(three_holidays).to be_a(Array)
    expect(three_holidays.count).to eq(3)
    three_holidays.each do |holiday|
      expect(holiday).to have_key(:localName)
      expect(holiday).to have_key(:date)
      expect(Date.parse(holiday[:date])).to be > (Date.today)
      expect(holiday[:localName]).to be_a(String)
    end
  end

  it 'returns the name and date of upcoming US holidays' do
    holidays = HolidayService.name_and_date_next_three_holidays

    expect(holidays).to be_a(Array)
    holidays.each do |holiday|
      expect(holiday).to be_a(String)
    end
  end
end