require 'rails_helper'

describe 'bulk discount show' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @discount1 = BulkDiscount.create!(name: 'Cheap Things', percentage: 20, quantity_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(name: 'Mythical Deals', percentage: 30, quantity_threshold:15, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(name: 'Surplus Value', percentage: 40, quantity_threshold: 20, merchant_id: @merchant1.id)
    @discount4 = BulkDiscount.create!(name: 'Discount Galore', percentage: 50, quantity_threshold: 25, merchant_id: @merchant2.id)
  
    visit merchant_bulk_discount_path(@merchant1, @discount1)
  end

  describe 'user story 4' do
    it 'displays the bulk discounts quantity threshold and percentage discount' do
      expect(page).to have_content(@discount1.name)
      expect(page).to have_content(@discount1.percentage)
      expect(page).to have_content(@discount1.quantity_threshold)

      visit merchant_bulk_discount_path(@merchant1, @discount2)

      expect(page).to have_content(@discount2.name)
      expect(page).to have_content(@discount2.percentage)
      expect(page).to have_content(@discount2.quantity_threshold)
    end
  end  

  describe 'user story 5' do
    it 'displays a link to edit the bulk discount' do
      expect(page).to have_link('Edit')
      click_link 'Edit'
   
      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1))
    end
  end  
end
