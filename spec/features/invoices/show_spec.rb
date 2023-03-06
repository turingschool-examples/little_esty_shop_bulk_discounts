require 'rails_helper'

RSpec.describe 'merchant/:merchant_id/invoices', type: :feature do
  before :each do
    ### MERCHANTS & ITEMS ###
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

    ### CUSTOMERS ###
    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
    @customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
    @customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
    @customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    @customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Kuhn')

    ### INVOICES, INVOICE_ITEMS, & TRANSACTIONS ###
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    ###
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-28 14:54:09")
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 2)
    @invoice_8 = Invoice.create!(customer_id: @customer_6.id, status: 1)

    ####
    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
    @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 12, unit_price: 6, status: 1)
    @ii_10 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_5.id, quantity: 40, unit_price: 1.33, status: 1)
    ####
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 2)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_3.id, quantity: 3, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_7.id, quantity: 1, unit_price: 3, status: 1)
    @ii_8 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_8.id, quantity: 1, unit_price: 5, status: 1)
    @ii_9 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
    # @ii_10 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_5.id, quantity: 1, unit_price: 1, status: 1)

    ###
    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    ###
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_2.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_3.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_4.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_5.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 0, invoice_id: @invoice_6.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_7.id)
    @transaction8 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_8.id)
  
    ### BULK DISCOUNTS for Merchant1 ###
    @bd_basic = @merchant1.bulk_discounts.create!(title: "Basic", percentage_discount: 0.1, quantity_threshold: 5)
    @bd_super = @merchant1.bulk_discounts.create!(title: "Super", percentage_discount: 0.25, quantity_threshold: 10)
    @bd_seasonal = @merchant1.bulk_discounts.create!(title: "Seasonal", percentage_discount: 0.05, quantity_threshold: 5)

    visit merchant_invoice_path(@merchant1, @invoice_1)
  end

  context "as a merchant, when I visit my merchant invoice show page" do
    it "shows the invoice information" do
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %-d, %Y"))
    end

    it "shows the customer information" do
      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
      expect(page).to_not have_content(@customer_2.last_name)
    end

    it "shows the item information" do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@ii_1.quantity)
      expect(page).to have_content(@ii_1.unit_price)
      # This is a poorly written test since there can be many '5' on the page
      # if time to refactor, rewrite this test:
      # expect(page).to_not have_content(@ii_4.unit_price)
    end

    # Updated this test to clearly state what was being returned: 
    it "shows the total revenue for this invoice" do
      expect(page).to have_content("Revenue for Entire Invoice: $215.20")
    end

    it "shows a select field to update the invoice status" do
      within("#the-status-#{@ii_1.id}") do
        page.select("cancelled")
        click_button("Update Invoice")

        expect(page).to have_content("cancelled")
      end

      within("#current-invoice-status") do
        expect(page).to_not have_content("in progress")
      end
    end

    # User Story 6 (#merch_total_revenue)
    it "shows the total revenue for this invoice (NOT including bulk discounts)" do
      expect(page).to have_content("Total Revenue for Merchant on this Invoice: $162.00")
    end

    # User Story 6 (#merch_discount_amount)
    xit "I see the total DISCOUNTED revenue for my merchant from this invoice" do
      expect(page).to have_content("Total Discounted Revenue: $135.00")
    end

    # User Story 7 (#applied_bulk_discount)
    it "next to each invoice item, I see a link to the show page for the bulk discount that was applied (if any)" do 
      expect(page).to have_content("See Applied Bulk Discount")
      
      within "#inv_item-#{@ii_1.id}" do
        expect(page).to have_link("Basic", href: "/merchant/#{@merchant1.id}/bulk_discounts/#{@bd_basic.id}")
      end

      within "#inv_item-#{@ii_11.id}" do
        expect(page).to have_link("Super", href: "/merchant/#{@merchant1.id}/bulk_discounts/#{@bd_super.id}")
      end

      within "#inv_item-#{@ii_10.id}" do
        expect(page).to have_content("No Discount")
      end
    end

    # User Story 7 (#applied_bulk_discount)
    it "I click on that link & am taken to the bulk discount show page" do 
      within "#inv_item-#{@ii_1.id}" do
        click_link("Basic")
      end

      expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/#{@bd_basic.id}")

      expect(page).to have_content("Details for Bulk Discount: #{@bd_basic.title}")
      expect(page).to have_content("Precentage Discount (as a decimal): #{@bd_basic.percentage_discount}")
      expect(page).to have_content("Quantity Threshold (for same item): #{@bd_basic.quantity_threshold}")
    end
  end
end
