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
      expect(@i1.status).to eq('complete')
    end
  end
end

describe 'merchant invoice show page toal revenue and discounted revenue' do 
  let!(:merchant_1) {Merchant.create!(name: 'Hair Care')}

  let!(:bulk_discount_1) {merchant_1.bulk_discounts.create!(markdown: 10, quantity_threshold: 10)}
  let!(:bulk_discount_2) {merchant_1.bulk_discounts.create!(markdown: 20, quantity_threshold: 20)}

  let!(:customer_1) {Customer.create!(first_name: 'Joey', last_name: 'Smith')}
  let!(:customer_2) {Customer.create!(first_name: 'Patsy', last_name: 'Cline')}

  let!(:invoice_1) {customer_1.invoices.create!(status: 2)}
  let!(:invoice_2) {customer_2.invoices.create!(status: 2)}
  let!(:invoice_3) {customer_2.invoices.create!(status: 2)}
  let!(:invoice_4) {customer_2.invoices.create!(status: 2)}

  let!(:item_1) {merchant_1.items.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10)}
  let!(:item_2) {merchant_1.items.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 20)}
  let!(:item_3) {merchant_1.items.create!(name: "Head Band", description: "This Keeps hair out of your face", unit_price: 30)}
  let!(:item_4) {merchant_1.items.create!(name: "Curlers", description: "This makes hair curly", unit_price: 40)}

  let!(:i_i_1) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 100, unit_price: 10, status: 2)} 
  let!(:i_i_2) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 10, unit_price: 20, status: 2)} 
  let!(:i_i_3) {InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_3.id, quantity: 1, unit_price: 30, status: 2)} 
  let!(:i_i_4) {InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_4.id, quantity: 1, unit_price: 40, status: 2)} 
  let!(:i_i_5) {InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_1.id, quantity: 1, unit_price: 10, status: 2)} 
  let!(:i_i_6) {InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_2.id, quantity: 1, unit_price: 20, status: 2)} 
  let!(:i_i_7) {InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_3.id, quantity: 1, unit_price: 30, status: 2)} 
  let!(:i_i_8) {InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_1.id, quantity: 1, unit_price: 10, status: 2)} 
  let!(:i_i_9) {InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_2.id, quantity: 20, unit_price: 20, status: 2)} 
  let!(:i_i_10) {InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_3.id, quantity: 20, unit_price: 30, status: 2)} 
  
  it 'shows total revenue for invoice not including discounts' do 
    visit admin_invoice_path(invoice_1)
    
    within "#revenue" do 
      
      expect(page).to have_content("Total Revenue: $1230.0")
      expect(page).to have_content("Total Discounted Revenue: $1010.0")
    end
  end
end
