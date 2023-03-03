require 'rails_helper'

RSpec.describe "Merchant Bulk Discounts Index" do

  before each: do 
    @merchant1 = Merchant.create!(name: 'Dudes Haberdashery')
    @customer1 = Customer.create!(first_name: 'Jeff', last_name: 'Elledge')
    @discount1 = @merchant.bulk_discounts.create!(percentage_discount: 0.20 ,quantity_threshhold: 10)
    @discount2 = @merchant.bulk_discounts.create!(percentage_discount: 0.10 , quantity_threshhold: 5)
    @item_1 = @merchant.item.create!(name: "Doodad", description: "Its a doodad", unit_price: 10, merchant_id: @merchant1.id)
    @item_2 = @merchant.item.create!(name: "Gadget", description: "Its a handy gadget", unit_price: 10, merchant_id: @merchant1.id)
    @item_3 = @merchant.item.create!(name: "thingamajig", description: "Clearly a thingamajig ", unit_price: 10, merchant_id: @merchant1.id)
    @invoice1 = @customer1.invoices.create(status: 0)
    @invoice2 = @customer1.invoices.create(status: 0)
    @invoice_item1 = InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item.id, quantity: 5, unit_price: 1, status: "pending")
    @invoice_item2 = InvoiceItem.create(invoice_id: @invoice1.id, item_id: @item.id, quantity: 10, unit_price: 1, status: "shipped")
    @invoice_item3 = InvoiceItem.create(invoice_id: @invoice2.id, item_id: @item.id, quantity: 5, unit_price: 1, status: "shipped")
    @invoice_item4 = InvoiceItem.create(invoice_id: @invoice2.id, item_id: @item.id, quantity: 10, unit_price: 1, status: "shipped")
    visit merchant_bulk_discount_path(@merchant)
  end
  describe "As a User" do 
    #user story 1
    describe "When I visit the merchants bulk discounts index" do
      it "I see all of my bulk discounts including their percentage discount and quantity thresholds" do
        expect(page).to have_content("Percentage Discount")
        expect(page).to have_content("Quantity Thresholds")
      end

      xit "And each bulk discount listed includes a link to its show page" do

      end
    end
  end
end