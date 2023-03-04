require 'rails_helper'

RSpec.describe 'merchant bulk discounts new' do
  describe 'As a merchant' do
    context "When I visit the bulk discounts new page" do
      before :each do
        @merchant1 = Merchant.create!(name: 'Hair Care')
        @merchant2 = Merchant.create!(name: 'Trippy Emporium')

        @bulk_discount1 = @merchant1.bulk_discounts.create!(percentage_discount: 0.2, quantity_threshold: 2, promo_name: "First Time Buyer")
        @bulk_discount2 = @merchant1.bulk_discounts.create!(percentage_discount: 0.3, quantity_threshold: 5, promo_name: "Loyalty Reward")
        @bulk_discount3 = @merchant2.bulk_discounts.create!(percentage_discount: 0.42, quantity_threshold: 10, promo_name: "420 Special")
        
        visit new_merchant_bulk_discount_path(@merchant2.id)
      end

      it "theres form to add a new bulk discount" do
        within('section#new_bulk_discount_form') do
          expect(page).to have_field(:promo_name)
          expect(page).to have_field(:discount_percentage)
          expect(page).to have_field(:quantity_threshold)
          expect(page).to have_button("Submit")
        end
      end
      
      it "can fill in the form with invalid data, and is redirected back to the bulk discount new page" do
      
      end

      xit "and a message appears letting the user know that their input was invalid" do

      end

      xit "can fill in the form with valid data, and is redirected back to the bulk discount index" do
      
      end

      
      xit "sees the new bulk discount listed and a flash message indicates a successful addition" do
      
      end
    end
  end
end

