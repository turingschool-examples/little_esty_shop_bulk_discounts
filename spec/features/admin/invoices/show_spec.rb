require 'rails_helper'

describe 'Admin Invoices Index Page' do
  describe 'setup' do
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

  describe 'discounts' do
    before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @merchant2 = Merchant.create!(name: 'Foot Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant2.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 12, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 15, unit_price: 10, status: 1)

      @discount = BulkDiscount.create!(merchant_id: @merchant1.id, quantity: 30, percentage: 15, name: 'Test'  )
      @discount_2 = BulkDiscount.create!(merchant_id: @merchant1.id, quantity: 10, percentage: 20, name: 'Test'  )

      visit admin_invoice_path(@invoice_1)
    end

    it 'shows the total discounted revenue section' do
      expect(page).to have_content("Total Discounted Revenue: $246.00")
    end

    it 'has a link for the discount that was applied next to the item' do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @merchant2 = Merchant.create!(name: 'Foot Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")

      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 12, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 9, unit_price: 10, status: 1)

      @discount_2 = BulkDiscount.create!(merchant_id: @merchant1.id, quantity: 10, percentage: 20, name: 'Test'  )

      visit admin_invoice_path(@invoice_1)

      within ".table" do
        expect(page).to have_link("#{@discount_2.name}")
        click_link "#{@discount_2.name}"
        expect(current_path).to eq merchant_bulk_discount_path(@merchant1, @discount_2)
      end

      visit admin_invoice_path(@invoice_1)

      within ".table" do
        expect(page).to have_content("No Discount Applied")
      end
      save_and_open_page
    end
  end
end
