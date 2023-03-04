require 'rails_helper'

describe 'bulk discounts new' do
  before do
    @merchant = create(:merchant)
    visit new_merchant_bulk_discount_path(@merchant)
  end
  it 'has a header' do
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

  it 'can submit valid data' do
    within('form') do
      fill_in 'Percent discounted', with: 20
      fill_in 'Quantity threshold', with: 10
      click_on 'Submit'
    end
    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
    expect(page).to have_content('20% off after 10 items purchased.')
  end

  describe 'sad paths' do
    it 'gets a flash message with invalid data (over 100 percent)' do
      within('form') do
        fill_in 'Percent discounted', with: 101
        fill_in 'Quantity threshold', with: 10
        click_on 'Submit'
        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant))
      end
      expect(page).to have_content('Invalid input')
    end

    it 'gets a flash message with invalid data (less than 0 quantity)' do
      within('form') do
        fill_in 'Percent discounted', with: 50
        fill_in 'Quantity threshold', with: -1
        click_on 'Submit'
        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant))
      end
      expect(page).to have_content('Invalid input')
    end

    it 'gets a flash message with invalid data (less than 0 percent discounted)' do
      within('form') do
        fill_in 'Percent discounted', with: -1
        fill_in 'Quantity threshold', with: 10
        click_on 'Submit'
        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant))
      end
      expect(page).to have_content('Invalid input')
    end

    it 'gets a flash message with invalid data (empty fields)' do
      within('form') do
        click_on 'Submit'
        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant))
      end
      expect(page).to have_content('Invalid input')
    end
  end
end
