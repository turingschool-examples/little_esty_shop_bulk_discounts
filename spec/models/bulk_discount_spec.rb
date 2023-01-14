require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:percentage) }
    it { should validate_numericality_of(:percentage) }
    it { is_expected.to validate_presence_of(:quantity_threshold) }
    it { should validate_numericality_of(:quantity_threshold) }
  end
end