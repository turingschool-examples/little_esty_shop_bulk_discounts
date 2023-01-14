require 'rails_helper'

describe Discount do
  describe "validations" do
    it { should validate_presence_of :percentage }
    it { should validate_presence_of :threshold }
  end

  describe "relationships" do
    it { should belong_to :merchant }
  end
end