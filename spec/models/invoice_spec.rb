require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :transactions}
    it { should have_many :invoice_items}
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:bulk_discounts).through(:merchants) }
  end
  describe "instance methods" do
    it "total_revenue" do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)

      expect(@invoice_1.total_revenue).to eq(100)
    end

    describe '#all_item_discount_savings' do
      describe 'discount cases' do
        it "example 1" do
          @merchant1 = Merchant.create!(name: 'Hair Care')
          @bulk_discount1a = @merchant1.bulk_discounts.create!(percentage_discount: 0.2, quantity_threshold: 10)
    
          @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
          @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
    
          @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
       
          @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    
          @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 5, unit_price: 10, status: 2)
          @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 5, unit_price: 10, status: 1)
    
          expect(@invoice_1.all_item_discount_savings).to eq([])
        end

        it "example 2" do
          @merchant1 = Merchant.create!(name: 'Hair Care')
          @bulk_discount1a = @merchant1.bulk_discounts.create!(percentage_discount: 0.2, quantity_threshold: 10)
    
          @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
          @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
    
          @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
       
          @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    
          @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: 10, status: 2)
          @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 5, unit_price: 10, status: 1)
          
          savings = @invoice_1.all_item_discount_savings
          expect(savings.length).to eq(1)
          expect(savings[0].id).to eq(@ii_1.id)
          expect(savings[0].max_savings).to eq(20.0)
          expect(savings[0].max_discount).to eq(0.2)
        end

        it "example 3" do
          @merchant1 = Merchant.create!(name: 'Hair Care')
          @bulk_discount1a = @merchant1.bulk_discounts.create!(percentage_discount: 0.2, quantity_threshold: 10)
          @bulk_discount1b = @merchant1.bulk_discounts.create!(percentage_discount: 0.3, quantity_threshold: 15)
    
          @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
          @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
    
          @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
       
          @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    
          @ii_1a = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 12, unit_price: 10, status: 2)
          @ii_1b = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 15, unit_price: 10, status: 1)
          
          savings = @invoice_1.all_item_discount_savings

          expect(savings.length).to eq(2)
          expect(savings[0].id).to eq(@ii_1a.id)
          expect(savings[0].max_savings).to eq(24.0)
          expect(savings[0].max_discount).to eq(0.2)
          
          expect(savings[1].id).to eq(@ii_1b.id)
          expect(savings[1].max_savings).to eq(45.0)
          expect(savings[1].max_discount).to eq(0.3)
        end

        it "example 4" do
          @merchant1 = Merchant.create!(name: 'Hair Care')
          @bulk_discount1a = @merchant1.bulk_discounts.create!(percentage_discount: 0.2, quantity_threshold: 10)
          @bulk_discount1b = @merchant1.bulk_discounts.create!(percentage_discount: 0.15, quantity_threshold: 15)
    
          @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
          @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
    
          @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
       
          @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    
          @ii_1a = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 12, unit_price: 10, status: 2)
          @ii_1b = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 15, unit_price: 10, status: 1)
          
          savings = @invoice_1.all_item_discount_savings

          expect(savings.length).to eq(2)

          expect(savings[0].id).to eq(@ii_1a.id)
          expect(savings[0].max_savings).to eq(24.0)
          expect(savings[0].max_discount).to eq(0.2)

          expect(savings[1].id).to eq(@ii_1b.id)
          expect(savings[1].max_savings).to eq(30.0)
          expect(savings[1].max_discount).to eq(0.2)
        end

        it "example 5" do
          @merchant1 = Merchant.create!(name: 'Hair Care')
          @bulk_discount1a = @merchant1.bulk_discounts.create!(percentage_discount: 0.2, quantity_threshold: 10)
          @bulk_discount1b = @merchant1.bulk_discounts.create!(percentage_discount: 0.3, quantity_threshold: 15)
          @item_1a = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
          @item_1b = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
          
          @merchant2 = Merchant.create!(name: 'Melon Care')
          @item_2a = Item.create!(name: "Melon Scooper", description: "Scoops melons", unit_price: 5, merchant_id: @merchant2.id)
    
          @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
          @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    
          @ii_1a = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1a.id, quantity: 12, unit_price: 10, status: 2)
          @ii_1b = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1b.id, quantity: 15, unit_price: 10, status: 1)

          @ii_2a = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2a.id, quantity: 15, unit_price: 10, status: 1)

          savings = @invoice_1.all_item_discount_savings

          expect(savings.length).to eq(2)

          expect(savings[0].id).to eq(@ii_1a.id)
          expect(savings[0].max_savings).to eq(24.0)
          expect(savings[0].max_discount).to eq(0.2)

          expect(savings[1].id).to eq(@ii_1b.id)
          expect(savings[1].max_savings).to eq(45.0)
          expect(savings[1].max_discount).to eq(0.3)
        end
      end
    end

    describe '#total_savings' do
      it 'returns the integer value of the total savings on an invoice' do
        @merchant1 = Merchant.create!(name: 'Hair Care')
        @bulk_discount1a = @merchant1.bulk_discounts.create!(percentage_discount: 0.2, quantity_threshold: 10)
        @bulk_discount1b = @merchant1.bulk_discounts.create!(percentage_discount: 0.3, quantity_threshold: 15)
        @item_1a = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
        @item_1b = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
        
        @merchant2 = Merchant.create!(name: 'Melon Care')
        @item_2a = Item.create!(name: "Melon Scooper", description: "Scoops melons", unit_price: 5, merchant_id: @merchant2.id)
  
        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
        @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
  
        @ii_1a = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1a.id, quantity: 12, unit_price: 10, status: 2)
        @ii_1b = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1b.id, quantity: 15, unit_price: 10, status: 1)

        @ii_2a = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2a.id, quantity: 15, unit_price: 10, status: 1)

        expect(@invoice_1.total_savings).to eq(69.0)
      end
    end

    describe '#total_discounted_revenue' do
      it 'returns the total discounted revenue of an invoice' do
        @merchant1 = Merchant.create!(name: 'Hair Care')
        @bulk_discount1a = @merchant1.bulk_discounts.create!(percentage_discount: 0.2, quantity_threshold: 10)
        @bulk_discount1b = @merchant1.bulk_discounts.create!(percentage_discount: 0.3, quantity_threshold: 15)
        @item_1a = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
        @item_1b = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
        
        @merchant2 = Merchant.create!(name: 'Melon Care')
        @item_2a = Item.create!(name: "Melon Scooper", description: "Scoops melons", unit_price: 5, merchant_id: @merchant2.id)
  
        @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
        @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
  
        @ii_1a = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1a.id, quantity: 12, unit_price: 10, status: 2)
        @ii_1b = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1b.id, quantity: 15, unit_price: 10, status: 1)

        @ii_2a = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2a.id, quantity: 15, unit_price: 10, status: 1)

        expect(@invoice_1.total_discounted_revenue).to eq(351.0)
      end
    end
  end
end
