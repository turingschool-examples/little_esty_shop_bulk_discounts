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

  describe 'user story 4' do
    it 'displays the bulk discounts quantity threshold and percentage discount' do
      visit merchant_bulk_discount_path(@merchant1, @discount1)
# save_and_open_page
      expect(page).to have_content(@discount1.name)
      expect(page).to have_content(@discount1.percentage)
      expect(page).to have_content(@discount1.quantity_threshold)
    end
  end  

#   5: Merchant Bulk Discount Edit

# As a merchant
# When I visit my bulk discount show page
# Then I see a link to edit the bulk discount
# When I click this link
# Then I am taken to a new page with a form to edit the discount
# And I see that the discounts current attributes are pre-poluated in the form
# When I change any/all of the information and click submit
# Then I am redirected to the bulk discount's show page
# And I see that the discount's attributes have been updated
  describe 'user story 5' do
    it 'displays a link to edit the bulk discount' do
      visit merchant_bulk_discount_path(@merchant1, @discount1)

      expect(page).to have_link('Edit')
      click_link 'Edit'
      # save_and_open_page
      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1))
    end

    it 'shows a form filled in with the current attributes' do
      visit merchant_bulk_discount_path(@merchant1, @discount1)

      # expect(find_field('Name').value).to eq(@discount1.name)
      expect(find_field('Percentage').value).to eq(@discount1.percentage)
      expect(find_field('Quantity threshold').value).to eq(@discount1.quantity_threshold)

      expect(find_field('Name').value).to_not eq(@discount2.name)
    end 

    it "can fill in form, click submit, and redirect to that bulk discount's show page and see updated info" do
      visit merchant_bulk_discount_path(@merchant1, @discount1)

      # fill_in "Name", with: "Boogaly boo"
      fill_in "Percentage", with: "100"
      fill_in "Quantity threshold", with: "1"

      click_button "Submit"

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
      # expect(page).to have_content("Boogaly boo")
      expect(page).to have_content("100")
      expect(page).to have_content("1")
      # expect(page).to have_no_content("Cheap Things")
      expect(page).to have_content("20")
      expect(page).to have_content("10")
    end
    #why the f isn't it showing the atrributes...Have a great day future me!
  end  
end
