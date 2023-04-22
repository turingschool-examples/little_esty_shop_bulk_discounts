require 'rails_helper'

RSpec.describe 'bulk discounts index', type: :feature do
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

    @bulk_discount_1 = BulkDiscount.create!(percentage_discount: 10, quantity_threshold: 10, merchant_id: @merchant1.id)
    @bulk_discount_2 = BulkDiscount.create!(percentage_discount: 25, quantity_threshold: 15, merchant_id: @merchant1.id)

    visit merchant_bulk_discounts_path(@merchant1)
  end

  describe 'bulk discounts index' do
    describe 'User Story 1' do
      it 'I will see all my bulk discounts, their percentage discount, and quantity thresholds' do
        within "#bulk-discount-#{@bulk_discount_1.id}" do
          expect(page).to have_content(@bulk_discount_1.percentage_discount)
          expect(page).to have_content(@bulk_discount_1.quantity_threshold)
        end
        
        within "#bulk-discount-#{@bulk_discount_2.id}" do
          expect(page).to have_content(@bulk_discount_2.percentage_discount)
          expect(page).to have_content(@bulk_discount_2.quantity_threshold)
        end
      end
      
      it 'I will see a link to each bulk discount show page' do
        within "#bulk-discount-#{@bulk_discount_1.id}" do
          expect(page).to have_link("Discount ID: #{@bulk_discount_1.id} Show Page")
        end

        within "#bulk-discount-#{@bulk_discount_2.id}" do
          expect(page).to have_link("Discount ID: #{@bulk_discount_2.id} Show Page")
        end
      end

      it 'when I click on a link to a bulk discount show page, I am taken to that page' do
        within "#bulk-discount-#{@bulk_discount_1.id}" do
          click_link "Discount ID: #{@bulk_discount_1.id} Show Page"

          expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @bulk_discount_1))
        end

        visit merchant_bulk_discounts_path(@merchant1)

        within "#bulk-discount-#{@bulk_discount_2.id}" do
          click_link "Discount ID: #{@bulk_discount_2.id} Show Page"

          expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @bulk_discount_2))
        end
      end
    end

    describe 'User Story 2 (Create Action)' do
      it 'I will see a link to create a new bulk discount' do
        within "#new-discount-link" do
          expect(page).to have_link("New Discount")
        end
      end

      it 'when I click the link I am taken to a new page with a form' do
        within "#new-discount-link" do
          click_link "New Discount"
        end

        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
      end
    end

    describe 'User Story 3 (Delete Action)' do
      it 'I will see a link next to each discount to delete the discount' do
        within "#bulk-discount-#{@bulk_discount_1.id}" do
          expect(page).to have_button("Delete Discount")
        end

        within "#bulk-discount-#{@bulk_discount_2.id}" do
          expect(page).to have_button("Delete Discount")
        end
      end

      it 'when I click the link I am redirected back to the bulk discounts index page, and I no longer see the discount' do
        within "#bulk-discount-#{@bulk_discount_2.id}" do
          click_button "Delete Discount"

          expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
        end
        expect(page).to have_content("Percentage Discount: #{@bulk_discount_1.percentage_discount}")
        expect(page).to have_content("Quantity Threshold: #{@bulk_discount_1.quantity_threshold}")

        expect(page).to_not have_content("Percentage Discount: #{@bulk_discount_2.percentage_discount}")
        expect(page).to_not have_content("Quantity Threshold: #{@bulk_discount_2.quantity_threshold}")
      end
    end
  end
end