require 'rails_helper'

RSpec.describe HolidayFacade do

  it 'can get all holidays' do
    holidays = HolidayFacade.all_holidays
    expect(holidays[0]).to be_a Holiday
    expect(holidays[0].date).to be_a String
    expect(holidays[0].name).to be_a String
  end

  it 'can get the next three holidays' do
    next_three = HolidayFacade.next_three

    test = next_three.map do |holiday|
      holiday.date != Date.today
    end

    expect(next_three.count).to eq 3
    expect(test).to eq [true, true, true]
  end

end