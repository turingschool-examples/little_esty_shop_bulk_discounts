require 'rails_helper'

RSpec.describe "As a merchant" do
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

    @discount1 = BulkDiscount.create!(percent_off: 15, quantity: 15, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(percent_off: 25, quantity: 25, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(percent_off: 10, quantity: 10, merchant_id: @merchant2.id)
  end

  describe 'When I visit my bulk discounts index' do
    it 'Then I see a link to create a new discount' do
      visit merchant_bulk_discounts_path(@merchant1)

      expect(page).to have_link("New Bulk Discount")
    end

    describe 'When I click this link' do
      it 'Then I am taken to a new page where I see a form to add a new bulk discount' do
        visit merchant_bulk_discounts_path(@merchant1)
        click_link('New Bulk Discount')
        # save_and_open_page

        expect(page.current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
        expect(page).to have_content("Percent Off:")
        expect(page).to have_content("Quantity Required:")
        expect(page).to have_button("Add Bulk Discount")
      end

      # describe 'When I fill in the form with valid data' do
      #   it 'Then I am redirected back to the bulk discount index' do
      #
      #   end
      #
      #   it 'And I see my new bulk discount listed' do
      #
      #   end
      # end
    end
  end
end
