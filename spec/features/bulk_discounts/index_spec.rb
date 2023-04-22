require 'rails_helper'

RSpec.describe "merchant bulk discounts index page" do
  describe "when I visit my bulk discounts index page" do
    before(:each) do
      @merch_1 = create(:merchant)
      @merch_2 = create(:merchant)
      @bulk_discount_1 =@merch_1.bulk_discounts.create!(percent_discount: 15, quantity_threshold: 10)
      @bulk_discount_2 =@merch_1.bulk_discounts.create!(percent_discount: 25, quantity_threshold: 2)
      @bulk_discount_3 =@merch_2.bulk_discounts.create!(percent_discount: 10, quantity_threshold: 5)
    end
  
    it "displays all of my bulk discounts and the bulk discount attributes" do
      visit merchant_bulk_discounts_path(@merch_1)
     
      within("#discount-deets-#{@bulk_discount_1.id}")do

        expect(page).to have_content("This discount gives 15.0% off when you buy 10.")
        expect(page).to_not have_content("This discount gives 25.0% off when you buy 2.")
        expect(page).to_not have_content("This discount gives 10.0% off")
      end

      within("#discount-deets-#{@bulk_discount_2.id}") do

        expect(page).to have_content("This discount gives 25.0% off when you buy 2.")
        expect(page).to_not have_content("This discount gives 15.0% off when you buy 10.")
        expect(page).to_not have_content("when you buy 5.")
      end
    end

    it 'displays a link to create a new discount' do
      visit merchant_bulk_discounts_path(@merch_1)

      within("#discount-deets") do

        expect(page).to have_link "New Discount", href: new_merchant_bulk_discount_path(@merch_1)
        
        click_link "New Discount"

        expect(current_path).to eq(new_merchant_bulk_discount_path(@merch_1.id))
      end
    end
  end
end
    