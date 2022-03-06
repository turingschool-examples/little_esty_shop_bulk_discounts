require 'rails_helper'

RSpec.describe Holiday do
  it 'exists and has attributes' do

    data = {
    date: "2022-11-11",
    localName: "Veterans Day",
    name: "Veterans Day",
    countryCode: "US",
    types: [
      "Public"
    ]
    }
    holiday = Holiday.new(data)
    expect(holiday).to be_a(Holiday)
    expect(holiday.name).to eq("Veterans Day")
    expect(holiday.date).to eq("2022-11-11")
    end
  end
