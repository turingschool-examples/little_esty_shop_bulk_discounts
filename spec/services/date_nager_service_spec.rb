require 'rails_helper'

RSpec.describe DateNagerService do
  it 'can get all holidays' do
    holidays = DateNagerService.get_holidays
    expect(holidays).to be_a Array
    expect(holidays[0]).to be_a Hash
    expect(holidays[0]).to have_key :date
    expect(holidays[0]).to have_key :name
  end

end