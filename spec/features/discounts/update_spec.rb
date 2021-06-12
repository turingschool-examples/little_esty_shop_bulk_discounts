require 'rails_helper'

RSpec.describe 'merchant discounts index' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @discount1 = Discount.create!(percentage_discount: 0.25, quantity_threshold: 5, merchant_id: @merchant1.id)

    visit edit_merchant_discount_path(@merchant1, @discount1)
  end
  describe '#update' do
  #   Merchant Bulk Discount Edit

  # As a merchant
  # When I visit my bulk discount show page
  # Then I see a link to edit the bulk discount
  # When I click this link
  # Then I am taken to a new page with a form to edit the discount
  # And I see that the discounts current attributes are pre-poluated in the form
  # When I change any/all of the information and click submit
  # Then I am redirected to the bulk discount's show page
  # And I see that the discount's attributes have been updated
    it 'updates a discounts attributes' do
      expect(find_field('percentage_discount').value).to eq '0.25'
      expect(find_field('quantity_threshold').value).to eq '5'

      fill_in 'percentage_discount',	with: 0.33
      fill_in 'quantity_threshold',	with: 25

      click_button 'Save'

      expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))
      expect(page).to have_content(0.33)
      expect(page).to have_content(25)
    end
  end
end
