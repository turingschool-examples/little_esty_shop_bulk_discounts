require 'rails_helper'

RSpec.describe 'dashboard/bulk_discounts index spec'do
  before :each do
    test_data
    visit bulk_discount_path(@bulk_disc1)
  end

  describe 'As a merchant, when I visit my bulk discount show page' do
    it 'has discount name' do
      expect(page).to have_content(@bulk_disc1.name)
    end
  end
end