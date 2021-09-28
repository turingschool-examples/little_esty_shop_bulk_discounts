require 'rails_helper'

RSpec.describe NagerHoliday do
  it 'returns a holiday name and date' do
    holiday_info = {:localName=>"Labor Day", :date=>"2021-09-06"}
    holiday = NagerHoliday.new(holiday_info)

    expect(holiday.holiday_name).to eq("Labor Day")
    expect(holiday.holiday_date).to eq("2021-09-06")
  end
end
