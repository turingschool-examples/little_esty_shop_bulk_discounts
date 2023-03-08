require 'rails_helper'

RSpec.describe 'merchant bulk discounts index' do
  describe 'As a merchant' do
    context "When I visit my bulk discounts index" do
      before :each do
        @merchant1 = Merchant.create!(name: 'Hair Care')
        @merchant2 = Merchant.create!(name: 'Trippy Emporium')

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

        @bulk_discount1 = @merchant1.bulk_discounts.create!(percentage_discount: 0.2, quantity_threshold: 2, promo_name: "First Time Buyer")
        @bulk_discount2 = @merchant1.bulk_discounts.create!(percentage_discount: 0.3, quantity_threshold: 5, promo_name: "Loyalty Reward")
        @bulk_discount3 = @merchant2.bulk_discounts.create!(percentage_discount: 0.42, quantity_threshold: 10, promo_name: "420 Special")
        visit merchant_bulk_discounts_path(@merchant1)
      end

      it "sees all bulk discounts, and their respective attributes" do 

        within("div##{@bulk_discount1.id}") do
          expect(page).to have_content(@bulk_discount1.promo_name)
          expect(page).to have_content("Discount: #{(@bulk_discount1.percentage_discount * 100)}%")
          expect(page).to have_content("Quantity Threshold: #{(@bulk_discount1.quantity_threshold)}")
        end

        within("div##{@bulk_discount2.id}") do
          expect(page).to have_link(@bulk_discount2.promo_name)
          expect(page).to have_content("Discount: #{(@bulk_discount2.percentage_discount * 100)}%")
          expect(page).to have_content("Quantity Threshold: #{(@bulk_discount2.quantity_threshold)}")
        end
      end

      it "sees that each bulk discount listed includes a link to its show page" do
        within("div##{@bulk_discount1.id}") do
          expect(page).to have_link(@bulk_discount1.promo_name)
          click_link @bulk_discount1.promo_name
        end

        expect(current_path).to eq(merchant_bulk_discount_path(@merchant1.id, @bulk_discount1.id))
      end

      it "sees a link to create a new discount, clicks the link, and is taken to a bulk discount new page " do
        within("section#new_discount") do
          expect(page).to have_link("Create A New Bulk Discount")
          click_link "Create A New Bulk Discount"
        end

        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1.id))
      end

      it "next to each bulk discount I see a link to delete it" do
        
        within("div##{@bulk_discount1.id}") do
          expect(page).to have_button("Delete")
        end

        within("div##{@bulk_discount2.id}") do
          expect(page).to have_button("Delete")
        end
      end

      it "it clicks this link, is redirected back to the bulk discounts index page, and no longer see the discount listed" do
        within("div##{@bulk_discount1.id}") do
          click_button "Delete"
        end

        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1.id))

        within("section#bulk_discounts_list") do
          expect(page).to_not have_content("Promo: #{@bulk_discount1.promo_name} - Delete Promo")
          expect(page).to_not have_content("Discount: #{(@bulk_discount1.percentage_discount * 100)}%")
          expect(page).to_not have_content("Quantity Threshold: #{(@bulk_discount1.quantity_threshold)}")
        end
      end

      context "Holidays API" do
        it "has a section with a header of 'Upcoming Holidays' which has the name and date of the next 3 upcoming US holidays listed" do
          @holidays = HolidayFacade.next_3_upcoming_holidays
          
          within('section#upcoming_holidays') do
            @holidays.each do |holiday|
              expect(page).to have_content(holiday.name)
              expect(page).to have_content(holiday.date)
            end
          end
        end
      end
    end
  end
end