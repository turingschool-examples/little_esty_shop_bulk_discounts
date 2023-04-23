require 'rails_helper'

describe BulkDiscount, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :bulk_discounts_items }
    it { should have_many :items, through: :bulk_discounts_items }
  end
end
