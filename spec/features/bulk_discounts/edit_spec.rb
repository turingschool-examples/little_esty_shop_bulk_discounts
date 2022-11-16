require 'rails_helper'

RSpec.describe 'Edit Bulk Discount' do 
  before :each do
    @merchant1 = Merchant.create!(name: "Kevin's Illegal goods")
    @merchant2 = Merchant.create!(name: "Denver PC parts")
    @merchant3 = Merchant.create!(name: "Card Shop")

    @discount1 = BulkDiscount.create!(percentage: 10, quantity_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(percentage: 20, quantity_threshold: 20, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(percentage: 30, quantity_threshold: 30, merchant_id: @merchant3.id)
  end

  describe 'Edit form' do 
    it 'On bulk discount show page, I see a link to edit the discount' do 

      visit merchant_bulk_discount_path(@merchant1, @discount1)

      expect(page).to have_link("Edit Discount")

    end

    it 'When I click the link I am taken to a new page with a form to edit the discount' do 
      visit merchant_bulk_discount_path(@merchant1, @discount1)

      click_link("Edit Discount")

      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1))
    end

    it "I see that the discounts current attributes are pre-populated in the form" do
      visit edit_merchant_bulk_discount_path(@merchant1, @discount1)

      expect(page).to have_field('percentage', with: '10')
      expect(page).to have_field('quantity_threshold', with: '10')
      expect(page).to_not have_content(@discount2.percentage)
      expect(page).to_not have_content(@discount2.quantity_threshold)
    end
    
    it 'When I change any/ all info of the discount and click submit, I am redirected to b.discount show page. Info is updated' do 
      visit edit_merchant_bulk_discount_path(@merchant1, @discount1)
      
      fill_in "percentage", with: 15
      
      fill_in "quantity_threshold", with: 15
      
      click_button("Submit")
      
      expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))

      
      expect(page).to have_content("Percentage: 15%")
      expect(page).to have_content("Min Qnty: 15")
    end

  end
end