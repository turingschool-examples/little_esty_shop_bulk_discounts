require 'rails_helper'

RSpec.describe NagerService do
  before :each do
    @response = '[{"date": "2021-09-06",
      "localName": "Labor Day",
      "name": "Labour Day",
      "countryCode": "US",
      "types": [
      "Public"]},
      {"date": "2021-10-11",
      "localName": "Columbus Day",
      "name": "Columbus Day",
      "countryCode": "US",
      "types": [
      "Public"]},
      {"date": "2021-11-11",
      "localName": "Veterans Day",
      "name": "Veterans Day",
      "countryCode": "US",
      "types": [
      "Public"]},
      {"date": "2021-11-25",
      "localName": "Thanksgiving Day",
      "name": "Thanksgiving Day",
      "countryCode": "US",
      "fixed": false,
      "global": true,
      "counties": null,
      "launchYear": 1863,
      "types": [
      "Public"]}]'

    allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(Faraday::Response.new)

    allow_any_instance_of(Faraday::Response).to receive(:body).and_return(@response)
  end

  it 'returns information about the next three holidays' do
    holiday = NagerService.holiday_info

    expect(holiday).to be_a(Array)
    expect(holiday.first).to have_key(:date)
    expect(holiday.first).to have_key(:localName)
    expect(holiday.second).to have_key(:date)
    expect(holiday.second).to have_key(:localName)
    expect(holiday.third).to have_key(:date)
    expect(holiday.third).to have_key(:localName)
  end

  it 'returns the next 3 holidays' do
    next_three_holidays = NagerService.next_three_holidays

    expect(next_three_holidays.first.holiday_name).to eq("Labor Day")
    expect(next_three_holidays.first.holiday_date).to eq("2021-09-06")
  end
end
