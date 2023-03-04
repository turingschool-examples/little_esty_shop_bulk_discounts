require 'rails_helper'

describe 'bulk discounts new' do
  before do 
    @merchant = create(:merchant)
    visit new_merchant_bulk_discount_path(@merchant)
  end
  it 'has a header' do
    save_and_open_page
    expect(page).to have_content("Create a new Bulk Discount for #{@merchant.name}")
  end

  it 'has form fields' do
    within('form') do
      expect(page).to have_content('Percent discounted')
      expect(page).to have_field('Percent discounted')
      expect(page).to have_content('Quantity threshold')
      expect(page).to have_field('Quantity threshold')
      expect(page).to have_button('Submit')
    end
  end

  it 'can submit valid dates' do
    within('form') do
      fill_in 'Percent discounted', with: 20
      fill_in 'Quantity threshold', with: 10
      click_on 'Submit'
      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
    end
  end
end