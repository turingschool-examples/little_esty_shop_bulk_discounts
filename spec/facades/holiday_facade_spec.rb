require 'rails_helper'

 RSpec.describe 'holiday_facade' do
   it "can create instances of holiday dates and names", :vcr do
     #record api once and puts it in fixture folder. stubbing it out so your not making external calls every time
     holidays = HolidayFacade.create_holidays

     holidays.each do |holiday|
       expect(holiday).to be_an_instance_of(HolidayDate)
     end
   end
 end
