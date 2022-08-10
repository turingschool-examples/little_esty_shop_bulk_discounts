require 'rails_helper'

RSpec.describe NagerService do
  it 'exists' do
    ns = NagerService.holidays

    expect(ns).to be_a(Array)
  end
end
