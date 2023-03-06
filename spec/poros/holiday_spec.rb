RSpec.describe Holiday do
  describe "#initialize" do
    let(:holiday_data) { { name: "Christmas", date: "2022-12-25" } }
    let(:holiday) { Holiday.new(holiday_data) }

    it "sets the name attribute" do
      expect(holiday.name).to eq("Christmas")
    end

    it "sets the date attribute as a Date object" do
      expect(holiday.date).to be_a(Date)
      expect(holiday.date).to eq(Date.new(2022, 12, 25))
    end
  end
end