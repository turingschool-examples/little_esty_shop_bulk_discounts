require 'rails_helper'

describe 'bulk discount show' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')

    @discount1 = BulkDiscount.create!(name: 'Cheap Things', percentage: 20, quantity_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(name: 'Mythical Deals', percentage: 30, quantity_threshold:15, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(name: 'Surplus Value', percentage: 40, quantity_threshold: 20, merchant_id: @merchant1.id)
    @discount4 = BulkDiscount.create!(name: 'Discount Galore', percentage: 50, quantity_threshold: 25, merchant_id: @merchant2.id)
  end

  describe 'user story 5' do

    it 'shows a form filled in with the current attributes' do
      visit edit_merchant_bulk_discount_path(@merchant1, @discount1)

      expect(find_field('Name').value).to eq(@discount1.name)
      expect(find_field('Percentage').value).to eq(@discount1.percentage.to_s)
      expect(find_field('Quantity threshold').value).to eq(@discount1.quantity_threshold.to_s)

      expect(find_field('Name').value).to_not eq(@discount2.name)
    end 

    xit "can fill in form, click submit, and redirect to that bulk discount's show page and see updated info" do
      edit_merchant_bulk_discount_path(@merchant1, @discount1)
      #how do I change it from saying disabled
      # find_field "Name".set(name)
      fill_in "bulk_discount[name]", with: "Boogaly boo"
      fill_in "bulk_discount[percentage]", with: "100"
      fill_in "bulk_discount[quantity_thrshold]", with: "1"

      click_button "Submit"

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
      expect(page).to have_content("Boogaly boo")
      expect(page).to have_content("100")
      expect(page).to have_content("1")
      expect(page).to have_no_content("Cheap Things")
      expect(page).to have_content("20")
      expect(page).to have_content("10")
    end
  end
end 