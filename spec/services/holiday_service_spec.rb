require 'rails_helper'

RSpec.describe HolidayService do
  describe "class#methods" do
    context "self.next_3_upcoming_holidays" do
      it "returns the next 3 upcoming holidays from the endpoint" do
      # You want to test data types & keys as opposed to the specific values of a variable, as seen up
      # to now with testing Models
        holidays = HolidayService.next_3_upcoming_holidays
        expect(holidays).to be_a(Array)
        
        holidays.each do |holiday| #Iterating through portion of the response body to check data types & keys
          expect(holiday).to have_key(:name)
          expect(holiday[:name]).to be_a(String)
          expect(holiday).to have_key(:date)
          expect(holiday[:date]).to be_a(String)
        end
      end
    end
  end
end