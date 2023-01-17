require 'rails_helper'

RSpec.describe Holiday do
  it 'exists' do
    data = {
      date: '2023-02-20',
      localName: 'Presidents Day',
      countryCode: 'US'
    }

    holiday = Holiday.new(data)

    expect(holiday).to be_a Holiday
    expect(holiday.name).to eq 'Presidents Day'
    expect(holiday.country_code).to eq 'US'
    expect(holiday.date).to eq '2023-02-20'
  end
end