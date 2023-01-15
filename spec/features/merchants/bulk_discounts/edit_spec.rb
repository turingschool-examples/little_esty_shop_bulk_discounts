require 'rails_helper'

RSpec.describe 'Edit Bulk Discount' do
  describe 'User story 5' do
# As a merchant
# When I visit my bulk discount show page
# Then I see a link to edit the bulk discount
# When I click this link
# Then I am taken to a new page with a form to edit the discount
# And I see that the discounts current attributes are pre-poluated in the form
# When I change any/all of the information and click submit
# Then I am redirected to the bulk discount's show page
# And I see that the discount's attributes have been updated
    it 'has a pre-populated form to edit the discount' do
      merchant_1 = create(:merchant)

      bulk_discount_1 = merchant_1.bulk_discounts.create!(quantity_threshold: 10, percentage: 5)

      visit merchant_bulk_discount_path(merchant_1, bulk_discount_1.id)

      expect(page).to have_content("Quantity Threshold: 10")
      expect(page).to have_content("Percentage: 5")
      
      click_link('Edit bulk discount')
      
      fill_in('quantity_threshold', with: 20)
      click_button('Update bulk discount')
      
      expect(current_path).to eq(merchant_bulk_discount_path(merchant_1, bulk_discount_1.id))
      expect(page).to have_content("Quantity Threshold: 20")
      expect(page).to have_content("Percentage: #{bulk_discount_1.percentage}")
      expect(page).to_not have_content("Quantity Threshold: 10")
      
      click_link('Edit bulk discount')
      
      fill_in('percentage', with: 15)
      click_button('Update bulk discount')
      
      expect(current_path).to eq(merchant_bulk_discount_path(merchant_1, bulk_discount_1.id))
      expect(page).to have_content("Percentage: 15")
      expect(page).to have_content("Quantity Threshold: 20")
      expect(page).to_not have_content("Percentage: 5")
    end
  end
end