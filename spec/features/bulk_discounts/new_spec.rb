require 'rails_helper'

RSpec.describe 'Bulk Discount New', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Hair Care')

    visit new_merchant_bulk_discount_path(@merchant_1)
  end

  describe 'User Story 2' do
    it 'has a form to create a new bulk discount' do
      expect(page).to have_field(:percentage_discount)
      expect(page).to have_field(:quantity_threshold)
    end
    
    it 'when I fill in the form with valid data, I am redirected back to the bulk discounts index page'
    it 'and I see my new bulk discount listed'

# where I see a form to add a new bulk discount
# When I fill in the form with valid data
# Then I am redirected back to the bulk discount index
# And I see my new bulk discount listed
  end
end