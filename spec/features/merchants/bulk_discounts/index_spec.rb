require 'rails_helper'

RSpec.describe 'Bulk Discount Index Page' do
# Part 1: As a merchant
# When I visit my merchant dashboard
# Then I see a link to view all my discounts
# When I click this link
# Then I am taken to my bulk discounts index page
# Part 2: Where I see all of my bulk discounts including their
# percentage discount and quantity thresholds
# And each bulk discount listed includes a link to its show page
  describe 'User story 1 (part 2)' do
    it 'I see all the bulk discounts (as links), with their percentage and quantity thresholds' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      bulk_discount_1 = merchant_1.bulk_discounts.create!(quantity_threshold: 10, percentage: 5)
      bulk_discount_2 = merchant_1.bulk_discounts.create!(quantity_threshold: 15, percentage: 10)
      bulk_discount_3 = merchant_1.bulk_discounts.create!(quantity_threshold: 20, percentage: 20)
      bulk_discount_4 = merchant_1.bulk_discounts.create!(quantity_threshold: 30, percentage: 25)
      bulk_discount_5 = merchant_1.bulk_discounts.create!(quantity_threshold: 50, percentage: 30)

      customer_1 = create(:customer)

      items_1 = create_list(:item, 5, unit_price: 50)
      items = create_list(:item, 8, unit_price: 10)

      visit merchant_bulk_discounts_path(merchant_1)
      # visit "/merchant/#{merchant_1.id}/bulk_discounts"

      expect(page).to have_link("#{bulk_discount_1.id}")
      expect(page).to have_content("Quantity Threshold: #{bulk_discount_1.quantity_threshold}")
      expect(page).to have_content("Percentage: #{bulk_discount_1.percentage}")

      expect(page).to have_link("#{bulk_discount_2.id}")
      expect(page).to have_content("Quantity Threshold: #{bulk_discount_2.quantity_threshold}")
      expect(page).to have_content("Percentage: #{bulk_discount_2.percentage}")

      expect(page).to have_link("#{bulk_discount_3.id}")
      expect(page).to have_content("Quantity Threshold: #{bulk_discount_3.quantity_threshold}")
      expect(page).to have_content("Percentage: #{bulk_discount_3.percentage}") 
    end

  describe 'User story 2 (part 1)'
    it 'has a link to create a new bulk discount' do
      merchant_1 = create(:merchant)

      bulk_discount_1 = merchant_1.bulk_discounts.create!(quantity_threshold: 10, percentage: 5)
      bulk_discount_2 = merchant_1.bulk_discounts.create!(quantity_threshold: 15, percentage: 10)
      bulk_discount_3 = merchant_1.bulk_discounts.create!(quantity_threshold: 20, percentage: 20)
      bulk_discount_4 = merchant_1.bulk_discounts.create!(quantity_threshold: 30, percentage: 25)
      bulk_discount_5 = merchant_1.bulk_discounts.create!(quantity_threshold: 50, percentage: 30)

      customer_1 = create(:customer)

      items_1 = create_list(:item, 5, unit_price: 50)
      items = create_list(:item, 8, unit_price: 10)

      visit merchant_bulk_discounts_path(merchant_1)

      expect(page).to have_link('Create bulk discount')
    end
  end
  
  describe 'User story 3 (part 1)' do
    it 'has a link to remove a bulk discount next to each bulk discount' do
      merchant_1 = create(:merchant)

      bulk_discount_1 = merchant_1.bulk_discounts.create!(quantity_threshold: 10, percentage: 5)
      bulk_discount_2 = merchant_1.bulk_discounts.create!(quantity_threshold: 15, percentage: 10)

      customer_1 = create(:customer)

      items_1 = create_list(:item, 5, unit_price: 50)
      items = create_list(:item, 8, unit_price: 10)

      visit merchant_bulk_discounts_path(merchant_1)

      within("#bulk_discount-#{bulk_discount_1.id}") do
        expect(page).to have_link("Delete bulk discount #{bulk_discount_1.id}")
        expect(page).to_not have_link("Delete bulk discount #{bulk_discount_2.id}")
      end
      
      within("#bulk_discount-#{bulk_discount_2.id}") do
        expect(page).to have_link("Delete bulk discount #{bulk_discount_2.id}")
        expect(page).to_not have_link("Delete bulk discount #{bulk_discount_1.id}")
      end
    end
  end
end