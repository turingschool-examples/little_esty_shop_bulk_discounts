require 'rails_helper'

describe BulkDiscount do
  describe "validations" do
    it { should validate_presence_of :threshold }
    it { should validate_presence_of :discount_percent }
  end
  describe "relationships" do
    it { should belong_to :merchant }
  end
end