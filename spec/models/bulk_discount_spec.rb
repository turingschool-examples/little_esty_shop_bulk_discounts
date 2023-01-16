require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'validations' do
    it { should validate_presence_of :percentage_discount }
    it { should validate_numericality_of(:percentage_discount).is_less_than(1).is_greater_than(0) }
    it { should validate_presence_of :quantity_threshold }
    it { should validate_numericality_of(:quantity_threshold).only_integer.is_greater_than(0) }
  end

  describe 'relationships' do
    it { should belong_to :merchant}
  end
end