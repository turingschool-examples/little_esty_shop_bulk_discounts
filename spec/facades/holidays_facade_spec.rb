require 'rails_helper'

RSpec.describe HolidaysFacade do
  describe 'class methods' do
    describe '.next_holidays' do
      it 'returns an array of all upcoming holidays' do
        arr = HolidaysFacade.next_holidays
        expect(arr).to all be_a Holiday
      end
    end
    describe '.next_3_holidays' do
      it 'returns an array of the next 3 holidays' do
        expect(HolidaysFacade.next_3_holidays).to all be_a Holiday
        expect(HolidaysFacade.next_3_holidays.length).to eq(3)
      end
    end
  end
end