require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe "validations" do
    it { should validate_presence_of :percent_discount }
    it { should validate_presence_of :qty_threshold }
  end
  describe "relationships" do
    it { should belong_to :merchant }
  end
end
