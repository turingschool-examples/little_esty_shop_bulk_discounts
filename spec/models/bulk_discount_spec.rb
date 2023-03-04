require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'validations' do
    it { should validate_presence_of :percent_discounted }
    it { should validate_presence_of :quantity_threshold }
    it { should validate_numericality_of(:percent_discounted).only_integer.is_greater_than(0).is_less_than(101) }
    it { should validate_numericality_of(:quantity_threshold).only_integer.is_greater_than(0) }
  end
  describe 'relationships' do
    it { should belong_to :merchant }
  end
end
