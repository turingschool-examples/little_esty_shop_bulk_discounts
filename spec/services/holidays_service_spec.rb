require 'rails_helper'

RSpec.describe HolidaysService do
  describe 'class methods' do
    describe '.next_us_holidays' do
      it 'returns json data with holiday names and dates' do
        search = HolidaysService.next_us_holidays
        expect(search).to be_a Array
        holiday_data = search.first
        expect(holiday_data[:date]).to be_a String
        expect(holiday_data[:name]).to be_a String
        expect(holiday_data[:countryCode]).to eq("US")
      end
    end
  end
end