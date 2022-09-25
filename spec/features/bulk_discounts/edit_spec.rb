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

  describe 'When I visit the bulk discount edit page' do
    before :each do
      visit merchant_bulk_discount_path(@merchant1, @discount1)
      click_on("Edit Discount")
    end

    it "I see that the discounts current attributes are pre-poluated in the form" do
      expect(page.current_path).to eq edit_merchant_bulk_discount_path(@merchant1, @discount1)
      expect(page).to have_field('Percent Off', with: '15')
      expect(page).to have_field('Quantity Required', with: '15')
      expect(page).to have_field('Status', with: 'disabled')
    end

    describe 'When I change any/all of the information and click submit' do
      before :each do
        fill_in 'Percent Off', with: 25
        fill_in 'Quantity Required', with: 20
        select('enabled', from: :status)
        click_on 'Update Discount'
      end

      it "Then I am redirected to the bulk discount's show page" do
        expect(page.current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
      end

      it "And I see that the discount's attributes have been updated" do
        expect(page).to have_content('Percent Off: 25%')
        expect(page).to have_content('Quantity Required: 20')
        expect(page).to have_content('Status: enabled')

        expect(page).to_not have_content('Percent Off: 15%')
        expect(page).to_not have_content('Quantity Required: 15')
        expect(page).to_not have_content('Status: disabled')
      end
    end
  end
end
