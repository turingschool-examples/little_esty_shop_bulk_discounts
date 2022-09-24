require 'rails_helper'

RSpec.describe 'As a merchant' do
  describe 'When I visit my merchant bulk discount index' do
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
      @discount1 = BulkDiscount.create!(percent_off: 25, quantity: 25, merchant_id: @merchant1.id)
      @discount1 = BulkDiscount.create!(percent_off: 10, quantity: 10, merchant_id: @merchant2.id)
    end

    it 'Where I see all of my bulk discounts including their
      percentage discount and quantity thresholds
      And each bulk discount listed includes a link to its show page' do

      visit merchant_bulk_discount_path(@merchant1)

      within("#discount-#{discount1.id}") do
        expect(page).to have_content('Percentage: 15%')
        expect(page).to have_button('View Discount')
        expect(page).to have_content('Quantity Threshold: 15')
        expect(page).to have_content('Status: disabled')

        expect(page).to_not have_content('Percentage: 25%')
        expect(page).to_not have_content('Quantity Threshold: 25')
        expect(page).to_not have_content('Status: enabled')

      end

      within("#discount-#{discount2.id}") do
        expect(page).to have_content('Percentage: 25%')
        expect(page).to have_button('View Discount')
        expect(page).to have_content('Quantity Threshold: 25')
        expect(page).to have_content('Status: disabled')

        expect(page).to_not have_content('Percentage: 15%')
        expect(page).to_not have_content('Quantity Threshold: 15')
        expect(page).to_not have_content('Status: enabled')
      end

      visit merchant_bulk_discount_path(@merchant2)

      within("#discount-#{discount3.id}") do
        expect(page).to have_content('Percentage: 10%')
        expect(page).to have_button('View Discount')
        expect(page).to have_content('Quantity Threshold: 10')
        expect(page).to have_content('Status: disabled')

        expect(page).to_not have_content('Percentage: 25%')
        expect(page).to_not have_content('Percentage: 15%')
        expect(page).to_not have_content('Quantity Threshold: 25')
        expect(page).to_not have_content('Quantity Threshold: 15')
        expect(page).to_not have_content('Status: enabled')
      end
    end
  end
end
