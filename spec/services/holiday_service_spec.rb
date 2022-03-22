require 'rails_helper'

RSpec.describe HolidayService do
  let(:holidays) { HolidayService.holidays("US") }

  it 'establishes a connection for holidays in a desired coutnry', :vcr do 
    expect(holidays).to be_a(Array)
    holidays.each do |holiday|
      expect(holiday).to be_a(Hash)
      expect(holiday[:date]).to be_a(String)
      expect(holiday[:name]).to be_a(String)
    end
  end 
end