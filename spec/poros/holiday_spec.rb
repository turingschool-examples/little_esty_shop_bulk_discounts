require 'rails_helper'

RSpec.describe Holiday do

  it 'exists and has attributes' do
    holiday = Holiday.new({name: "Next", date: Date.today})

    expect(holiday).to be_a Holiday
    expect(holiday.name).to eq "Next"
    expect(holiday.date).to eq Date.today
  end
end