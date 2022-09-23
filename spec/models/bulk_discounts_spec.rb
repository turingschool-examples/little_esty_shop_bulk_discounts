require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe "validations" do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :percentage }
    it { should validate_presence_of :merchant_id }
  end
  describe "relationships" do
    it { should have_many :merchants }
    it { should have_many(:items).through(:merchants) }
    it {should have_many(:invoices).through(:invoice_items)}
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

end