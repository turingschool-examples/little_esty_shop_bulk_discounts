require 'rails_helper'

RSpec.describe 'US-1 Bulk Discount Index' do 
  before :each do 
    @merchant1 = Merchant.create!(name: "Kevin's Illegal goods")
    @merchant2 = Merchant.create!(name: "Denver PC parts")
    @merchant3 = Merchant.create!(name: "Card Shop")

    @customer1 = Customer.create!(first_name: "Sean", last_name: "Culliton")
    @customer2 = Customer.create!(first_name: "Sergio", last_name: "Azcona")
    @customer3 = Customer.create!(first_name: "Emily", last_name: "Port")

    @item1 = @merchant1.items.create!(name: "Funny Brick of Powder", description: "White Powder with Gasoline Smell", unit_price: 5000)
    @item2 = @merchant1.items.create!(name: "T-Rex", description: "Skull of a Dinosaur", unit_price: 100000)
    @item3 = @merchant2.items.create!(name: "UFO Board", description: "Out of this world MotherBoard", unit_price: 400)

    @invoice1 = Invoice.create!(status: 1, customer_id: @customer2.id, created_at: "2022-11-01 11:00:00 UTC")
    @invoice2 = Invoice.create!(status: 1, customer_id: @customer1.id, created_at: "2022-11-01 11:00:00 UTC")
    @invoice3 = Invoice.create!(status: 1, customer_id: @customer3.id, created_at: "2022-11-01 11:00:00 UTC")
    
    @invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: 5000, status: 0, item_id: @item1.id, invoice_id: @invoice1.id)
    @invoice_item2 =InvoiceItem.create!(quantity: 2, unit_price: 5000, status: 1, item_id: @item2.id, invoice_id: @invoice1.id)
    @invoice_item3 = InvoiceItem.create!(quantity: 54, unit_price: 8000, status: 2, item_id: @item3.id, invoice_id: @invoice2.id)

    
    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice3.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice2.id)

    @discount1 = BulkDiscount.create!(percentage: 10, quantity_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(percentage: 20, quantity_threshold: 20, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(percentage: 30, quantity_threshold: 30, merchant_id: @merchant3.id)
  end
  describe 'all bulk discounts displayed for a particular merchant' do 
    it 'I see all of my bulk discounts including their percentage discount and quantity thresholds.' do 

      visit merchant_bulk_discounts_path(@merchant1)
  
      expect(page).to have_content("Percentage: #{@discount1.percentage}%")
      expect(page).to have_content("Min Qnty: #{@discount1.quantity_threshold}")
      expect(page).to have_content("Percentage: #{@discount2.percentage}%")
      expect(page).to have_content("Min Qnty: #{@discount2.quantity_threshold}")
    

    end

    it 'each bulk discount listed includes a link to its show page' do 
      visit merchant_bulk_discounts_path(@merchant1)

      click_link("More Details #{@discount1.id}")
      
      expect(current_path).to eq(merchant_bulk_discount_path(@merchant1.id, @discount1.id))

    end
  end

  describe 'US-3: Discount Delete' do 

    it 'Next to each bulk discount I see a link to delete it' do 
      visit merchant_bulk_discounts_path(@merchant1)

      expect(page).to have_button("Delete Discount #{@discount1.id}")
    end

    it 'When i click the delete link I am redirected back to the bulk discounts index page and I no longer see the discount' do 
      visit merchant_bulk_discounts_path(@merchant1)
      
      click_on("Delete Discount #{@discount1.id}")
      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
      expect(page).to_not have_content(@discount1)
    end
  end
end