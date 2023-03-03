require "rails_helper"

describe BulkDiscount do
  describe  "relationships" do
    it { should belong_to :merchant}
  end
end