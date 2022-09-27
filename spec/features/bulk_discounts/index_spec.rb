require 'rails_helper'

RSpec.describe 'merchant dashboard' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

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

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_5 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_4.id, quantity: 1, unit_price: 5, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)

    @bulk_discount1 = BulkDiscount.create!(merchant_id: @merchant1.id, threshold: 5, discount_percent: 10)
    @bulk_discount2 = BulkDiscount.create!(merchant_id: @merchant1.id, threshold: 15, discount_percent: 20)
    visit merchant_bulk_discounts_path(@merchant1)
  end

  describe "as a Merchant, when I visit the page" do
    it "I see all of my bulk discounts including discount% and quantity thresholds" do
      expect(page).to have_content(@bulk_discount1.id)
      expect(page).to have_content(@bulk_discount2.id)
      expect(page).to have_content(@bulk_discount2.threshold)
      expect(page).to have_content(@bulk_discount1.discount_percent)
    end

    it "And each bulk discount listed includes a link to that discounts show page" do
      within "#discount-#{@bulk_discount1.id}" do
        expect(page).to have_link('View this Discount')
      end
      within "#discount-#{@bulk_discount1.id}" do
        expect(page).to have_link('View this Discount')
      end
    end

    it "when I click the link, I am taken to the show page for that discount" do
      within "#discount-#{@bulk_discount1.id}" do
        click_link "View this Discount"
        expect(current_path).to eq merchant_bulk_discount_path(@merchant1, @bulk_discount1)
      end
    end
  end

  describe ":creating a new discount:" do
    it "i see a button to create a new discount" do
      expect(page).to have_link("Create New Bulk Discount")
      click_link("Create New Bulk Discount")
      expect(current_path).to eq new_merchant_bulk_discount_path(@merchant1)
    end
  end

  describe ":editing discounts:" do
    it "next to each discount, I see a button to delete that discount" do
      within "#discount-#{@bulk_discount1.id}" do
        expect(page).to have_content(@bulk_discount1.threshold)
        expect(page).to have_button("Delete")
      end
    end

    it "when I click the button, I am redirected to the index page" do
      within "#discount-#{@bulk_discount1.id}" do
        click_button "Delete"
      end
      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    end

    it "and I no longer see that discount" do
      within "#discount-#{@bulk_discount1.id}" do
        click_button "Delete"
      end
      expect(page).to_not have_content("Bulk Discount: #{@bulk_discount1.id}")
    end
  end
end
