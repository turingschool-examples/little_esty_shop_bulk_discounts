require 'rails_helper'

RSpec.describe 'bulk discount index' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Hair Care')
    @merchant_2 = Merchant.create!(name: 'The Lazy Otter')

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
    @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
    @customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
    @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Kuhn')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)
    @invoice_8 = Invoice.create!(customer_id: @customer_6.id, status: 2)

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant_1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant_1.id)
    @item_5 = Item.create!(name: "Comb", description: "This makes your hair neat", unit_price: 2, merchant_id: @merchant_1.id)
    @item_6 = Item.create!(name: "Soap", description: "This probably shouldn't go in your hair", unit_price: 3, merchant_id: @merchant_1.id)
    @item_7 = Item.create!(name: "Whale T-Shirt", description: "It's a whale on a shirt", unit_price: 25, merchant_id: @merchant_2.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_5 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_8 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_5.id, quantity: 1, unit_price: 1, status: 1)
    @ii_9 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_6.id, quantity: 1, unit_price: 1, status: 1)
    @ii_10 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_7.id, quantity: 1, unit_price: 1, status: 1)

    @transaction_1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
    @transaction_3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
    @transaction_4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
    @transaction_5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
    @transaction_7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)
    @transaction_8 = Transaction.create!(credit_card_number: 102368, result: 1, invoice_id: @invoice_8.id)
    @transaction_9 = Transaction.create!(credit_card_number: 819769, result: 1, invoice_id: @invoice_8.id)

    @bulk_discount_1 = BulkDiscount.create(discount: 5, quantity: 10, merchant: @merchant_1)
    @bulk_discount_2 = BulkDiscount.create!(discount: 20, quantity: 20, merchant: @merchant_1)
    @bulk_discount_3 = BulkDiscount.create!(discount: 10, quantity: 10, merchant: @merchant_2)
    @bulk_discount_4 = BulkDiscount.create!(discount: 15, quantity: 30, merchant: @merchant_2)

    visit merchant_bulk_discounts_path(@merchant_1)
  end

  describe "User Story 1" do
    context "As a merchant when I visit my bulk discounts index" do
      it "I see all of my bulk discounts(with percentage discount and quantity) listed as a link to its show page" do

        within("#bulk_discount-#{@bulk_discount_1.id}") do
          expect(page).to have_link("Discount ID ##{@bulk_discount_1.id}")
          expect(page).to have_content("Discount: #{@bulk_discount_1.discount}")
          expect(page).to have_content(@bulk_discount_1.quantity)
          expect(page).to_not have_content(@bulk_discount_2.id)
        end
        
        within("#bulk_discount-#{@bulk_discount_2.id}") do
          expect(page).to have_link("Discount ID ##{@bulk_discount_2.id}")
          expect(page).to have_content("Discount: #{@bulk_discount_2.discount}")
          expect(page).to have_content("Item Threshold: #{@bulk_discount_2.quantity}")
          expect(page).to_not have_content(@bulk_discount_1.id)
        end
      end

      it "I see a message indicating that I have no bulk discounts if I do not have any" do
        merchant_without_bulk_discounts = Merchant.create!(name: 'No Discounts Ever Shop')
        visit merchant_bulk_discounts_path(merchant_without_bulk_discounts)
       
        expect(page).to have_content("You do not have any bulk discounts.")
      end
    end
  end

  describe "User Story 3" do
    context "As a merchant when I visit my bulk discounts index" do
      it "I see next to each discount a link to delete it, clicking this link I am redirected 
        back to the discounts index page and I no longer see the discount listed" do
      
        within("#bulk_discount-#{@bulk_discount_1.id}") do
          click_link("Delete Discount")
        end
        
        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))
        expect(page).to_not have_content(@bulk_discount_1.id)
        expect(page).to have_content(@bulk_discount_2.id)

        within("#bulk_discount-#{@bulk_discount_2.id}") do
          click_link("Delete Discount")
        end

        expect(page).to_not have_content(@bulk_discount_2.id)
      end
    end
  end

  describe "User Story 9" do
    context "As a merchant when I visit my bulk discounts index" do
      it "I see a section with a header of 'Upcoming Holidays'
        In this section the name and date of the next 3 upcoming US holidays are listed." do
   
        within("#holidays") do
          expect(page).to have_content("Good Friday")
          expect(page).to have_content("Memorial Day")
          expect(page).to have_content("Juneteenth")
        end
      end
    end
  end
end