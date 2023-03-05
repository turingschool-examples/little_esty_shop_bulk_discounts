require 'rails_helper'

describe BulkDiscount, type: :model do 
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many(:items).through(:merchant) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:percentage_discount) }
    it { should validate_presence_of(:quantity_threshold) }
    it { should validate_numericality_of(:percentage_discount) }
    it { should validate_numericality_of(:quantity_threshold) }
  end
end