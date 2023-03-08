require 'rails_helper'

RSpec.describe HolidayService do
  describe "class#methods" do
    context "self.next_3_upcoming_holidays" do
      it "returns the next 3 upcoming holidays from the endpoint" do
        holidays = HolidayService.next_3_upcoming_holidays
        expect(holidays).to be_a(Array)
        
        holidays.each do |holiday|
          expect(holiday).to have_key(:name)
          expect(holiday[:name]).to be_a(String)
          expect(holiday).to have_key(:date)
          expect(holiday[:date]).to be_a(String)
        end
      end
    end
  end
end