require 'rails_helper'

RSpec.describe 'Bulk Discount Index Page', type: :feature do
  before :each do
    @merchant = Merchant.create!(name: 'Hair Care')
    @discount_1 = @merchant.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 20)
    @discount_2 = @merchant.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 30)
    @discount_3 = @merchant.bulk_discounts.create!(percentage_discount: 40, quantity_threshold: 40)
    visit merchant_dashboard_index_path(@merchant)
  end
  describe 'As a merchant' do

    #user story 1
    describe 'When I visit my merchant index page' do
      it " I see a link to view all my discounts" do
        expect(page).to have_link("My Discounts")
        click_link("My Discounts")
        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
      end

      it "Then I am taken to my bulk discounts index page Where I see all of my bulk discounts including their percentage discount and quantity thresholds And each bulk discount listed includes a link to its show page" do
        click_link("My Discounts")
        expect(page).to have_content(@discount_1.percentage_discount)
        expect(page).to have_content(@discount_1.quantity_threshold)
        expect(page).to have_content(@discount_2.percentage_discount)
        expect(page).to have_content(@discount_2.quantity_threshold)
        expect(page).to have_content(@discount_3.percentage_discount)
        expect(page).to have_content(@discount_3.quantity_threshold)
        expect(page).to have_link(@discount_1.id)
        expect(page).to have_link(@discount_2.id)
        expect(page).to have_link(@discount_3.id)
      end
    end
    #user story 2
    describe "When I visit my bulk discounts index page" do
      it "Then I see a link to create a new discount" do
        click_link("My Discounts")
        expect(page).to have_link("Create New Discount")
        click_link("Create New Discount")
        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant))
      end
    end
    #user story 3
     describe "When I visit my bulk discounts index page" do
      it "Then I see a link to delete a discount" do
        click_link("My Discounts")
        within "#discounts-#{@discount_1.id}" do
          expect(page).to have_link("Delete Discount ##{@discount_1.id}")
          click_link("Delete Discount ##{@discount_1.id}")
        end 
        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
        expect(page).to_not have_content(@discount_1.id)
        expect(page).to_not have_content(@discount_1.percentage_discount)
        expect(page).to_not have_content(@discount_1.quantity_threshold)
      end
    end
  end
end