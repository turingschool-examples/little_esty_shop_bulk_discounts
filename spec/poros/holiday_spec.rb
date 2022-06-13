require "rails_helper"

RSpec.describe Holiday do

  it "exists" do
    juneteenth = Holiday.new({name: "Juneteenth", date: "2022-06-20"})
    expect(juneteenth).to be_a(Holiday)
  end

  it "has readable attributes" do
    juneteenth = Holiday.new({name: "Juneteenth", date: "2022-06-20"})
    expect(juneteenth.name).to eq("Juneteenth")
    expect(juneteenth.date).to eq("2022-06-20")
  end

end
