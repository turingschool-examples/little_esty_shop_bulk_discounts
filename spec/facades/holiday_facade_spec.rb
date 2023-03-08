require 'rails_helper'

RSpec.describe HolidayFacade do
  it "returns three Holiday POROs" do #Calls on the HolidayFacade and hits a pry in the object being created to observe the datas params and add them as attributes of the class(see holiday.rb)
    holidays = HolidayFacade.next_3_upcoming_holidays

    holidays.each do |holiday|
      expect(holiday).to be_a(Holiday)
    end
  end
end