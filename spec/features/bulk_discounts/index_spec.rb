require 'rails_helper'

RSpec.describe 'bulk discounts index page' do

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
    @bulk_discount_1 = @merchant.bulk_discounts.create!(name: "20% off of 10", percentage_discount: 0.20, quantity_threshold: 10)
    @bulk_discount_2 = @merchant.bulk_discounts.create!(name: "30% off of 20", percentage_discount: 0.30, quantity_threshold: 20)

    visit merchant_bulk_discounts_path(@merchant)
  end
  describe 'as a merchant' do
    context 'when I visit my bulk discounts index page' do
      it 'displays a list of all of my bulk discounts including their percentage discount and quantity thresholds' do
        expect(page).to have_content(@bulk_discount_1.percentage_discount)
        expect(page).to have_content(@bulk_discount_1.quantity_threshold)
        expect(page).to have_content(@bulk_discount_2.percentage_discount)
        expect(page).to have_content(@bulk_discount_2.quantity_threshold)
      end

      it 'each bulk discount listed includes a link to its show page' do
        expect(page).to have_link('20% off of 10')
        expect(page).to have_link('30% off of 20')
      end

      it 'displays a link to create a new bulk discount' do
        expect(page).to have_link('New Bulk Discount')
      end

      it 'next to each bulk discount I see a link to delete that bulk discount' do
        expect(page).to have_link('Delete 20% off of 10')
        expect(page).to have_link('Delete 30% off of 20')
      end

      it 'when I click the link to delete a bulk discount, I am redirected back to the bulk discounts index page where I no longer see that bulk discount' do
        click_link 'Delete 20% off of 10'
        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
        
        expect(page).to_not have_content(@bulk_discount_1.name)
        expect(page).to_not have_content(@bulk_discount_1.percentage_discount)
        expect(page).to_not have_content(@bulk_discount_1.quantity_threshold)

        expect(page).to have_content(@bulk_discount_2.name)
        expect(page).to have_content(@bulk_discount_2.percentage_discount)
        expect(page).to have_content(@bulk_discount_2.quantity_threshold)
      end
    end
  end
end