require 'rails_helper'

RSpec.describe 'bulk items index' do
  before :each do
    # @merchant = FactoryBot.create_list(:merchant, 3)
    # @bulk_discount = FactoryBot.create_list(:bulk_discount, 4)
    # require 'pry'; binding.pry
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @discount1 = BulkDiscount.create!(name: 'Cheap Things', percentage: 20, quantity_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(name: 'Mythical Deals', percentage: 30, quantity_threshold:15, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(name: 'Surplus Value', percentage: 40, quantity_threshold: 20, merchant_id: @merchant1.id)
    @discount4 = BulkDiscount.create!(name: 'Discount Galore', percentage: 50, quantity_threshold: 25, merchant_id: @merchant2.id)
    
    visit merchant_bulk_discounts_path(@merchant1)
  end

  describe 'user story 1'
    it 'shows all of my bulk discounts including their percentage discount and quantity thresholds' do
      # visit merchant_bulk_discounts_path(@merchant1)

      expect(page).to have_content(@discount1.name)
      expect(page).to have_content(@discount2.name)
      expect(page).to have_content(@discount3.name)
      expect(page).to_not have_content(@discount4.name)

      expect(page).to have_content(@discount1.percentage)
      expect(page).to have_content(@discount2.percentage)
      expect(page).to have_content(@discount3.percentage)
      expect(page).to_not have_content(@discount4.percentage)

      expect(page).to have_content(@discount1.quantity_threshold)
      expect(page).to have_content(@discount2.quantity_threshold)
      expect(page).to have_content(@discount3.quantity_threshold)
      expect(page).to_not have_content(@discount4.quantity_threshold)
    end

    it 'displays each bulk discount listed includes a link to its show page' do
      # visit merchant_bulk_discounts_path(@merchant1)
      save_and_open_page
      expect(page).to have_link(@discount1.name)
      expect(page).to have_link(@discount2.name)
      expect(page).to have_link(@discount3.name)
      expect(page).to_not have_link(@discount4.name)
    end

    # describe 'user story 1'
    # it 'shows all of my bulk discounts including their percentage discount and quantity thresholds' do
      # visit merchant_bulk_discounts_path(@merchant1)


# 2: Merchant Bulk Discount Create

# As a merchant
# When I visit my bulk discounts index
# Then I see a link to create a new discount
# When I click this link
# Then I am taken to a new page where I see a form to add a new bulk discount
# When I fill in the form with valid data
# Then I am redirected back to the bulk discount index
# And I see my new bulk discount listed
end  