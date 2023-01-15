require 'rails_helper'

RSpec.describe 'Bulk Discounts Show Page' do
  describe 'User story 4' do
# As a merchant
# When I visit my bulk discount show page
# Then I see the bulk discount's quantity threshold and percentage discount
    it 'displays the bulk discount quantity and percentage' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      bulk_discount_1 = merchant_1.bulk_discounts.create!(quantity_threshold: 10, percentage: 5)
      bulk_discount_2 = merchant_2.bulk_discounts.create!(quantity_threshold: 15, percentage: 15)

      visit merchant_bulk_discount_path(merchant_1, bulk_discount_1.id)

      expect(page).to have_content(bulk_discount_1.id)
      expect(page).to have_content(bulk_discount_1.quantity_threshold)
      expect(page).to have_content(bulk_discount_1.percentage)
      expect(page).to_not have_content(bulk_discount_2.id)
      expect(page).to_not have_content(bulk_discount_2.quantity_threshold)
      expect(page).to_not have_content(bulk_discount_2.percentage)
    end
  end

# As a merchant
# When I visit my bulk discount show page
# Then I see a link to edit the bulk discount
# When I click this link
# Then I am taken to a new page with a form to edit the discount
# And I see that the discounts current attributes are pre-poluated in the form
# When I change any/all of the information and click submit
# Then I am redirected to the bulk discount's show page
# And I see that the discount's attributes have been updated
  describe 'User story 5 (part 1)' do
    it 'has a link to the edit the bulk discount' do
      merchant_1 = create(:merchant)

      bulk_discount_1 = merchant_1.bulk_discounts.create!(quantity_threshold: 10, percentage: 5)

      visit merchant_bulk_discount_path(merchant_1, bulk_discount_1.id)

      expect(page).to have_link('Edit bulk discount')
    end
  end
end