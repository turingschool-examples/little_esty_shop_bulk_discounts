require "rails_helper"

RSpec.describe 'bulk discounts new page' do
  before :each do
    holiday_names_dates_call = File.read('spec/fixtures/holiday_names_dates_call.json')

    stub_request(:get, "https://date.nager.at/api/v3/NextPublicHolidays/US").
        with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
          }).
        to_return(status: 200, body: holiday_names_dates_call, headers: {})
  end

  before :each do 
    @merchant = Merchant.create!(name: 'Hair Care')
    visit new_merchant_bulk_discount_path(@merchant)
  end

  describe 'as a merchant' do
    context 'when I visit my bulk discounts new page' do
      it 'displays a form to create a new bulk discount' do
        expect(page).to have_field(:name)
        expect(page).to have_field(:percentage_discount)
        expect(page).to have_field(:quantity_threshold)
      end

      it 'displays a button to submit the form' do
        expect(page).to have_button('Create Bulk Discount')
      end

      it 'when fill out the form and I click on the submit button, I am redirected to the bulk discounts index page' do
        fill_in :name, with: '40% off of 30'
        fill_in :percentage_discount, with: 0.40
        fill_in :quantity_threshold, with: 30

        click_button 'Create Bulk Discount'
        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
        visit merchant_bulk_discounts_path(@merchant)

        expect(page).to have_content('40% off of 30')
      end

      it 'displays an error message if I do not fill out the form completely' do
        fill_in :percentage_discount, with: 0.40
        click_button 'Create Bulk Discount'
      
        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant))
        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("Quantity threshold can't be blank")
      end
    end
  end
end