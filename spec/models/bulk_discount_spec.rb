require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'validations' do
    it { should validate_presence_of :percentage_discount }
    it { should validate_presence_of :quantity_threshold }
    it { should validate_presence_of :promo_name }
    it { should validate_numericality_of(:percentage_discount).is_greater_than(0).is_less_than(1.00) }
    it { should validate_numericality_of(:quantity_threshold).is_greater_than(0) }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many(:items).through(:merchant) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'instance methods' do

  end

  describe 'class methods' do
    
  end
end