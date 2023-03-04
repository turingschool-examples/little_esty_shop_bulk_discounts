require 'rails_helper'

RSpec.describe "Merchant Bulk Discounts Index" do

  before :each do 
    @merchant1 = Merchant.create!(name: 'Dudes Haberdashery')
    @customer1 = Customer.create!(first_name: 'Jeff', last_name: 'Elledge')
    @discount1 = @merchant1.bulk_discounts.create!(percentage_discount: 0.20 ,quantity_threshold: 10)
    @discount2 = @merchant1.bulk_discounts.create!(percentage_discount: 0.10 , quantity_threshold: 5)
    @item_1 = @merchant1.items.create!(name: "Doodad", description: "Its a doodad", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = @merchant1.items.create!(name: "Gadget", description: "Its a handy gadget", unit_price: 10, merchant_id: @merchant1.id)
    @item_3 = @merchant1.items.create!(name: "thingamajig", description: "Clearly a thingamajig ", unit_price: 10, merchant_id: @merchant1.id)
    @invoice1 = @customer1.invoices.create(status: 0)
    @invoice2 = @customer1.invoices.create(status: 0)
    @invoice_item1 = InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item_1.id, quantity: 5, unit_price: 1, status: "pending")
    @invoice_item2 = InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item_1.id, quantity: 10, unit_price: 1, status: "shipped")
    @invoice_item3 = InvoiceItem.create(invoice_id: @invoice2.id, item_id: @item_1.id, quantity: 5, unit_price: 1, status: "shipped")
    @invoice_item4 = InvoiceItem.create(invoice_id: @invoice2.id, item_id: @item_1.id, quantity: 10, unit_price: 1, status: "shipped")
    visit merchant_bulk_discounts_path(@merchant1)
  end
 
  describe "As a User" do 
    #user story 1
    describe "When I visit the merchants bulk discounts index" do
      it "I see all of my bulk discounts including their percentage discount and quantity thresholds" do
        within("#discounts-#{@discount1.id}") do
          expect(page).to have_content("Discount: #{@discount1.percentage_discount * 100}%")
          expect(page).to have_content("Quantity Threshold: #{@discount1.quantity_threshold}")
        end 
      end

      it "Each bulk discount listed includes a link to its show page" do
        within("#discounts-#{@discount1.id}") do
          expect(page).to have_link("Discount ##{@discount1.id}'s Page")
          click_link("Discount ##{@discount1.id}'s Page")
          expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
        end
      end
      #user story 2
      it " I see a link to create a new discount" do 
        expect(page).to have_button("New Discount")
        click_button("New Discount")
        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
      end
      #user story 3
      it " Then next to each bulk discount I see a link to delete it " do
        
        within("#discounts-#{@discount1.id}") do
          expect(page).to have_button("Delete Discount")
          click_button("Delete Discount")
          expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
        end
        expect(page).to_not have_content("Discount ##{@discount1.id}'s Page")
      end
    end
  end
end