require 'rails_helper'

RSpec.describe "Holiday API service" do

  it "exists" do
    service = HolidaysService.new
    expect(service).to be_a(HolidaysService)
  end
end
