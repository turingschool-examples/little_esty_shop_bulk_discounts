require 'rails_helper'

RSpec.describe HolidayInfo do
  it 'has data' do
    mock_response = [
      {
        "date": "2021-07-05",
        "localName": "Independence Day",
        "name": "Independence Day",
        "countryCode": "US",
        "fixed": false,
        "global": true,
        "counties": nil,
        "launchYear": nil,
        "types": [
          "Public"
        ]
      },
      {
        "date": "2021-09-06",
        "localName": "Labor Day",
        "name": "Labour Day",
        "countryCode": "US",
        "fixed": false,
        "global": true,
        "counties": nil,
        "launchYear": nil,
        "types": [
          "Public"
        ]
      },
      {
        "date": "2021-10-11",
        "localName": "Columbus Day",
        "name": "Columbus Day",
        "countryCode": "US",
        "fixed": false,
        "global": false,
        "counties": [
          "US-AL",
          "US-AZ",
          "US-CO",
          "US-CT",
          "US-DC",
          "US-GA",
          "US-ID",
          "US-IL",
          "US-IN",
          "US-IA",
          "US-KS",
          "US-KY",
          "US-LA",
          "US-ME",
          "US-MD",
          "US-MA",
          "US-MS",
          "US-MO",
          "US-MT",
          "US-NE",
          "US-NH",
          "US-NJ",
          "US-NM",
          "US-NY",
          "US-NC",
          "US-OH",
          "US-OK",
          "US-PA",
          "US-RI",
          "US-SC",
          "US-TN",
          "US-UT",
          "US-VA",
          "US-WV"
        ],
        "launchYear": nil,
        "types": [
          "Public"
        ]
      },
      {
        "date": "2021-11-11",
        "localName": "Veterans Day",
        "name": "Veterans Day",
        "countryCode": "US",
        "fixed": false,
        "global": true,
        "counties": nil,
        "launchYear": nil,
        "types": [
          "Public"
        ]
      },
      {
        "date": "2021-11-25",
        "localName": "Thanksgiving Day",
        "name": "Thanksgiving Day",
        "countryCode": "US",
        "fixed": false,
        "global": true,
        "counties": nil,
        "launchYear": 1863,
        "types": [
          "Public"
        ]
      },
      {
        "date": "2021-12-24",
        "localName": "Christmas Day",
        "name": "Christmas Day",
        "countryCode": "US",
        "fixed": false,
        "global": true,
        "counties": nil,
        "launchYear": nil,
        "types": [
          "Public"
        ]
      },
      {
        "date": "2021-12-31",
        "localName": "New Year's Day",
        "name": "New Year's Day",
        "countryCode": "US",
        "fixed": false,
        "global": true,
        "counties": nil,
        "launchYear": nil,
        "types": [
          "Public"
        ]
      },
      {
        "date": "2022-01-17",
        "localName": "Martin Luther King, Jr. Day",
        "name": "Martin Luther King, Jr. Day",
        "countryCode": "US",
        "fixed": false,
        "global": true,
        "counties": nil,
        "launchYear": nil,
        "types": [
          "Public"
        ]
      },
      {
        "date": "2022-02-21",
        "localName": "Presidents Day",
        "name": "Washington's Birthday",
        "countryCode": "US",
        "fixed": false,
        "global": true,
        "counties": nil,
        "launchYear": nil,
        "types": [
          "Public"
        ]
      },
      {
        "date": "2022-05-30",
        "localName": "Memorial Day",
        "name": "Memorial Day",
        "countryCode": "US",
        "fixed": false,
        "global": true,
        "counties": nil,
        "launchYear": nil,
        "types": [
          "Public"
        ]
      }
    ]
    allow(HolidayService).to receive(:holiday_info).and_return(mock_response)
    info = HolidayInfo.new('us')
    expect(info.next_three).to be_a(Array)
    expect(info.info).to be_a(Array)
  end
end
