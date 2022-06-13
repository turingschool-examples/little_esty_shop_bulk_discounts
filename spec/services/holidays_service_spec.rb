require 'rails_helper'

RSpec.describe "Holiday API service" do

  it 'can get next holiday names from API' do
    service = HolidaysService.holidays[0..2]
    expect(service[0].name).to eq("Juneteenth")
    expect(service[1].name).to eq("Independence Day")
    expect(service[2].name).to eq("Labour Day")
  end

  it "can give the next three holiday's dates" do
    service = HolidaysService.holidays[0..2]
    expect(service[0].date).to eq("2022-06-20")
    expect(service[1].date).to eq("2022-07-04")
    expect(service[2].date).to eq("2022-09-05")
  end

end
