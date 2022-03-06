require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:percent_discount) }
    it { should validate_presence_of(:qty_threshold) }

    it { should validate_numericality_of(:qty_threshold) }
  end

  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:items).through(:merchant) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:merchant) }
  end
end
