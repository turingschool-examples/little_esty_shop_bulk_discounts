require 'rails_helper'

RSpec.describe 'dashboard/bulk_discounts index spec'do
  before :each do
    test_data
    visit bulk_discount_path(@bulk_disc1)
  end

  describe 'As a merchant, when I visit my bulk discount show page' do
    it 'I see the bulk discount quantity threshold and percentage discount' do
      expect(page).to have_content(@bulk_disc1.name)
      expect(page).to have_content(@bulk_disc1.discount_percent.to_i)
      expect(page).to have_content(@bulk_disc1.quantity_threshold)
    end
  end
end