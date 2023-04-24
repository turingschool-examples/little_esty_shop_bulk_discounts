require 'rails_helper'

RSpec.describe 'invoices show' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)
    @item_7 = Item.create!(name: "Scrunchie", description: "This holds up your hair but is bigger", unit_price: 3, merchant_id: @merchant1.id)
    @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)

    @item_5 = Item.create!(name: "Bracelet", description: "Wrist bling", unit_price: 200, merchant_id: @merchant2.id)
    @item_6 = Item.create!(name: "Necklace", description: "Neck bling", unit_price: 300, merchant_id: @merchant2.id)

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
    @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
    @customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
    @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Kuhn')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-28 14:54:09")
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 2)

    @invoice_8 = Invoice.create!(customer_id: @customer_6.id, status: 1)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 2)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_3.id, quantity: 3, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_7.id, quantity: 1, unit_price: 3, status: 1)
    @ii_8 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_8.id, quantity: 1, unit_price: 5, status: 1)
    @ii_9 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
    @ii_10 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_5.id, quantity: 1, unit_price: 1, status: 1)
    @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 12, unit_price: 6, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_2.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_3.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_4.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_5.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 0, invoice_id: @invoice_6.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_7.id)
    @transaction8 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_8.id)
  end

  it "shows the invoice information" do
    visit merchant_invoice_path(@merchant1, @invoice_1)

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %-d, %Y"))
  end

  it "shows the customer information" do
    visit merchant_invoice_path(@merchant1, @invoice_1)

    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.last_name)
    expect(page).to_not have_content(@customer_2.last_name)
  end

  it "shows the item information" do
    visit merchant_invoice_path(@merchant1, @invoice_1)

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@ii_1.quantity)
    expect(page).to have_content(@ii_1.unit_price)
    expect(page).to_not have_content(@ii_4.unit_price)

  end

  it "shows the total revenue for this invoice" do
    visit merchant_invoice_path(@merchant1, @invoice_1)

    expect(page).to have_content(@invoice_1.total_revenue)
  end

  it "shows a select field to update the invoice status" do
    visit merchant_invoice_path(@merchant1, @invoice_1)

    within("#the-status-#{@ii_1.id}") do
      page.select("cancelled")
      click_button "Update Invoice"

      expect(page).to have_content("cancelled")
     end

     within("#current-invoice-status") do
       expect(page).to_not have_content("in progress")
     end
  end

  it 'will show the total discounted revenue for the merchant for this invoice which includes bulk discounts in the calculation' do
    merchant = Merchant.create!(name: 'Discount Rev')

    bulk_discount_1 = BulkDiscount.create!(merchant_id: merchant.id, percentage_discount: 10, quantity_threshold: 20)
    bulk_discount_2 = BulkDiscount.create!(merchant_id: merchant.id, percentage_discount: 20, quantity_threshold: 25)
    
    customer = Customer.create!(first_name: "John", last_name: "Doe")

    invoice = Invoice.create!(customer_id: customer.id, status: 2)

    item_1 = Item.create!(name: "Item 1", description: "Item 1 desc", merchant_id: merchant.id, unit_price: 100)
    item_2 = Item.create!(name: "Item 2", description: "Item 2 desc", merchant_id: merchant.id, unit_price: 200)
    item_3 = Item.create!(name: "Item 3", description: "Item 3 desc", merchant_id: merchant.id, unit_price: 300)
    item_4 = Item.create!(name: "Item 4", description: "Item 4 desc", merchant_id: merchant.id, unit_price: 400)
    item_5 = Item.create!(name: "Item 5", description: "Item 5 desc", merchant_id: merchant.id, unit_price: 500)
    item_6 = Item.create!(name: "Item 6", description: "Item 6 desc", merchant_id: merchant.id, unit_price: 600)
    item_7 = Item.create!(name: "Item 7", description: "Item 7 desc", merchant_id: merchant.id, unit_price: 700)
    item_8 = Item.create!(name: "Item 8", description: "Item 8 desc", merchant_id: merchant.id, unit_price: 800)
    item_9 = Item.create!(name: "Item 9", description: "Item 9 desc", merchant_id: merchant.id, unit_price: 900)
    item_10 = Item.create!(name: "Item 10", description: "Item 10 desc", merchant_id: merchant.id, unit_price: 1000)

    InvoiceItem.create!(invoice_id: invoice.id, item_id: item_1.id, quantity: 5, unit_price: 100, status: 1)
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item_2.id, quantity: 5, unit_price: 200, status: 1)
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item_3.id, quantity: 10, unit_price: 300, status: 1)
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item_4.id, quantity: 10, unit_price: 400, status: 1)
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item_5.id, quantity: 15, unit_price: 500, status: 1)
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item_6.id, quantity: 15, unit_price: 600, status: 1)
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item_7.id, quantity: 20, unit_price: 700, status: 1)
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item_8.id, quantity: 20, unit_price: 800, status: 1)
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item_9.id, quantity: 25, unit_price: 900, status: 1)
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item_10.id, quantity: 25, unit_price: 1000, status: 1)
  
    visit merchant_invoice_path(merchant, invoice)

    expect(page).to have_content("Total Revenue After Discounts: $90,000")
  end

  it 'next to each invoice item, I see a link to the show page for the bulk discount that was applied (if any)' do
    merchant = Merchant.create!(name: 'Discount Rev')

    bulk_discount_1 = BulkDiscount.create!(merchant_id: merchant.id, percentage_discount: 10, quantity_threshold: 20)
    bulk_discount_2 = BulkDiscount.create!(merchant_id: merchant.id, percentage_discount: 20, quantity_threshold: 25)
    
    customer = Customer.create!(first_name: "John", last_name: "Doe")

    invoice = Invoice.create!(customer_id: customer.id, status: 2)

    item_1 = Item.create!(name: "Item 1", description: "Item 1 desc", merchant_id: merchant.id, unit_price: 100)
    item_2 = Item.create!(name: "Item 2", description: "Item 2 desc", merchant_id: merchant.id, unit_price: 200)
    item_3 = Item.create!(name: "Item 3", description: "Item 3 desc", merchant_id: merchant.id, unit_price: 300)
    item_4 = Item.create!(name: "Item 4", description: "Item 4 desc", merchant_id: merchant.id, unit_price: 400)
    item_5 = Item.create!(name: "Item 5", description: "Item 5 desc", merchant_id: merchant.id, unit_price: 500)
    item_6 = Item.create!(name: "Item 6", description: "Item 6 desc", merchant_id: merchant.id, unit_price: 600)
    item_7 = Item.create!(name: "Item 7", description: "Item 7 desc", merchant_id: merchant.id, unit_price: 700)
    item_8 = Item.create!(name: "Item 8", description: "Item 8 desc", merchant_id: merchant.id, unit_price: 800)
    item_9 = Item.create!(name: "Item 9", description: "Item 9 desc", merchant_id: merchant.id, unit_price: 900)
    item_10 = Item.create!(name: "Item 10", description: "Item 10 desc", merchant_id: merchant.id, unit_price: 1000)

    ii_1 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item_1.id, quantity: 5, unit_price: 100, status: 1)
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item_2.id, quantity: 5, unit_price: 200, status: 1)
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item_3.id, quantity: 10, unit_price: 300, status: 1)
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item_4.id, quantity: 10, unit_price: 400, status: 1)
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item_5.id, quantity: 15, unit_price: 500, status: 1)
    InvoiceItem.create!(invoice_id: invoice.id, item_id: item_6.id, quantity: 15, unit_price: 600, status: 1)
    ii_7 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item_7.id, quantity: 20, unit_price: 700, status: 1)
    ii_8 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item_8.id, quantity: 20, unit_price: 800, status: 1)
    ii_9 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item_9.id, quantity: 25, unit_price: 900, status: 1)
    ii_10 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item_10.id, quantity: 25, unit_price: 1000, status: 1)
  
    visit merchant_invoice_path(merchant, invoice)

    within "#discount-#{ii_7.id}" do
      expect(page).to have_link(bulk_discount_1.percentage_discount)
    end

    within "#discount-#{ii_8.id}" do
      expect(page).to have_link(bulk_discount_1.percentage_discount)
    end

    within "#discount-#{ii_9.id}" do
      expect(page).to have_link(bulk_discount_2.percentage_discount)
    end

    within "#discount-#{ii_10.id}" do
      expect(page).to have_link(bulk_discount_2.percentage_discount)
    end

    within "#discount-#{ii_1.id}" do
      expect(page).to have_content("No Discount")
    end

    within "#discount-#{ii_7.id}" do
      click_link bulk_discount_1.percentage_discount

      expect(current_path).to eq(merchant_bulk_discount_path(merchant, bulk_discount_1))
    end

    visit merchant_invoice_path(merchant, invoice)

    within "#discount-#{ii_9.id}" do
      click_link bulk_discount_2.percentage_discount

      expect(current_path).to eq(merchant_bulk_discount_path(merchant, bulk_discount_2))
    end
  end
end
