require 'rails_helper'

describe 'Admin Invoices Index Page' do
  before :each do
    @m1 = Merchant.create!(name: 'Merchant 1')

    @c1 = Customer.create!(first_name: 'Yo', last_name: 'Yoz', address: '123 Heyyo', city: 'Whoville', state: 'CO', zip: 12345)
    @c2 = Customer.create!(first_name: 'Hey', last_name: 'Heyz')

    @i1 = Invoice.create!(customer_id: @c1.id, status: 2, created_at: '2012-03-25 09:54:09')
    @i2 = Invoice.create!(customer_id: @c2.id, status: 1, created_at: '2012-03-25 09:30:09')

    @item_1 = Item.create!(name: 'test', description: 'lalala', unit_price: 6, merchant_id: @m1.id)
    @item_2 = Item.create!(name: 'rest', description: 'dont test me', unit_price: 12, merchant_id: @m1.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_1.id, quantity: 12, unit_price: 2, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_2.id, quantity: 6, unit_price: 1, status: 1)
    @ii_3 = InvoiceItem.create!(invoice_id: @i2.id, item_id: @item_2.id, quantity: 87, unit_price: 12, status: 2)

    visit admin_invoice_path(@i1)
  end

  it 'should display the id, status and created_at' do
    expect(page).to have_content("Invoice ##{@i1.id}")
    expect(page).to have_content("Created on: #{@i1.created_at.strftime("%A, %B %d, %Y")}")

    expect(page).to_not have_content("Invoice ##{@i2.id}")
  end

  it 'should display the customers name and shipping address' do
    expect(page).to have_content("#{@c1.first_name} #{@c1.last_name}")
    expect(page).to have_content(@c1.address)
    expect(page).to have_content("#{@c1.city}, #{@c1.state} #{@c1.zip}")

    expect(page).to_not have_content("#{@c2.first_name} #{@c2.last_name}")
  end

  it 'should display all the items on the invoice' do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)

    expect(page).to have_content(@ii_1.quantity)
    expect(page).to have_content(@ii_2.quantity)

    expect(page).to have_content("$#{@ii_1.unit_price}")
    expect(page).to have_content("$#{@ii_2.unit_price}")

    expect(page).to have_content(@ii_1.status)
    expect(page).to have_content(@ii_2.status)

    expect(page).to_not have_content(@ii_3.quantity)
    expect(page).to_not have_content("$#{@ii_3.unit_price}")
    expect(page).to_not have_content(@ii_3.status)
  end

  it 'should display the total revenue the invoice will generate' do
    expect(page).to have_content("Total Revenue: $#{@i1.total_revenue}")

    expect(page).to_not have_content(@i2.total_revenue)
  end

  it 'should have status as a select field that updates the invoices status' do
    within("#status-update-#{@i1.id}") do
      select('cancelled', :from => 'invoice[status]')
      expect(page).to have_button('Update Invoice')
      click_button 'Update Invoice'

      expect(current_path).to eq(admin_invoice_path(@i1))
      expect(@i1.status).to eq('completed')
    end
  end

  it 'I see the total revenus and the total discount revenue for this invoice' do
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
  
    visit admin_invoice_path(invoice)

    expect(page).to have_content("Total Revenue: $#{invoice.total_revenue}")
    expect(page).to have_content("Total Discounted Revenue: $#{invoice.total_revenue_after_discount}")
  end
end
