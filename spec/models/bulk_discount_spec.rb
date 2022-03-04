require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
  end

  describe 'validations' do
    it { should validate_presence_of :percentage }
    it { should validate_presence_of :threshold }
    it { should validate_numericality_of :threshold }
    it { should_not allow_value(0).for :percentage }
    it { should_not allow_value(101).for :percentage }
    it { should_not allow_value(-1).for :threshold }
  end
end
