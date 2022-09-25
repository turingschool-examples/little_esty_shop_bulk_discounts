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
      @discount2 = BulkDiscount.create!(percent_off: 25, quantity: 25, merchant_id: @merchant1.id)
      @discount3 = BulkDiscount.create!(percent_off: 10, quantity: 10, merchant_id: @merchant2.id)
    end

    it 'Where I see all of my bulk discounts including their
      percentage discount and quantity thresholds
      And each bulk discount listed includes a link to its show page' do

      visit merchant_bulk_discounts_path(@merchant1)

      within("#discount-#{@discount1.id}") do
        expect(page).to have_content('Percentage Off: 15%')
        expect(page).to have_button('View Discount')
        expect(page).to have_content('Quantity Required: 15')
        expect(page).to have_content('Status: disabled')
          #sad paths
        expect(page).to_not have_content('Percentage Off: 25%')
        expect(page).to_not have_content('Quantity Required: 25')
        expect(page).to_not have_content('Status: enabled')

      end

      within("#discount-#{@discount2.id}") do
        expect(page).to have_content('Percentage Off: 25%')
        expect(page).to have_button('View Discount')
        expect(page).to have_content('Quantity Required: 25')
        expect(page).to have_content('Status: disabled')

        expect(page).to_not have_content('Percentage Off: 15%')
        expect(page).to_not have_content('Quantity Required: 15')
        expect(page).to_not have_content('Status: enabled')
      end
          #test other merchant
      visit merchant_bulk_discounts_path(@merchant2)

      within("#discount-#{@discount3.id}") do
        expect(page).to have_content('Percentage Off: 10%')
        expect(page).to have_button('View Discount')
        expect(page).to have_content('Quantity Required: 10')
        expect(page).to have_content('Status: disabled')

        expect(page).to_not have_content('Percentage Off: 25%')
        expect(page).to_not have_content('Percentage Off: 15%')
        expect(page).to_not have_content('Quantity Required: 25')
        expect(page).to_not have_content('Quantity Required: 15')
        expect(page).to_not have_content('Status: enabled')

        click_button "View Discount"

        expect(page.current_path).to eq(merchant_bulk_discount_path(@merchant2, @discount3))
      end
    end
          #bulk discount delete
    it "Then next to each bulk discount I see a link to delete it" do
      visit merchant_bulk_discounts_path(@merchant1)

      within("#discount-#{@discount1.id}") do
        expect(page).to have_content('Percentage Off: 15%')
        expect(page).to have_button('Delete 15% Discount')
        expect(page).to_not have_button('Delete 25% Discount')
        expect(page).to_not have_button('Delete 10% Discount')
      end

      within("#discount-#{@discount2.id}") do
        expect(page).to have_content('Percentage Off: 25%')
        expect(page).to have_button('Delete 25% Discount')
        expect(page).to_not have_button('Delete 15% Discount')
        expect(page).to_not have_button('Delete 10% Discount')
      end

      visit merchant_bulk_discounts_path(@merchant2)

      within("#discount-#{@discount3.id}") do
        expect(page).to have_content('Percentage Off: 10%')
        expect(page).to have_button('Delete 10% Discount')
        expect(page).to_not have_button('Delete 15% Discount')
        expect(page).to_not have_button('Delete 25% Discount')
      end
    end

    describe 'When I click this link' do
      it 'Then I am redirected back to the bulk discounts index page' do
        visit merchant_bulk_discounts_path(@merchant1)

        click_button('Delete 25% Discount')
        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
      end

      it 'And I no longer see the discount listed' do
        visit merchant_bulk_discounts_path(@merchant1)

        click_button('Delete 15% Discount')
        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
        expect(page).to have_content('Percentage Off: 25%')
        expect(page).to_not have_content('Percentage Off: 15%')
        expect(page).not_to have_content('Percentage Off: 10%')
      end
    end
  end
end
