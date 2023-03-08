require 'rails_helper'

RSpec.describe Holiday do
  it "exists" do
    holiday = HolidayFacade.next_3_upcoming_holidays.first
    expect(holiday).to be_a(Holiday)
  end
  
  it "has readable attributes" do
    holiday = HolidayFacade.next_3_upcoming_holidays.first
    
    expect(holiday.name).to eq("Good Friday")
    expect(holiday.date).to eq("2023-04-07")
  end
end