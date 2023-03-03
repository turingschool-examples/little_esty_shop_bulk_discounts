require 'rails_helper'
RSpec.describe 'bulk discounts edit page' do
  before :each do
    @merchant = Merchant.create!(name: 'Hair Care')
    @bulk_discount_1 = @merchant.bulk_discounts.create!(name: "20% off of 10", percentage_discount: 0.20, quantity_threshold: 10)
    visit edit_merchant_bulk_discount_path(@merchant, @bulk_discount_1)
  end

  describe 'as a merchant' do
    context 'when I visit my bulk discount edit page' do
      it 'displays a form with the bulk discount attributes' do
        expect(page).to have_field('Name')
        expect(page).to have_field('Percentage discount')
        expect(page).to have_field('Quantity threshold')
      end

      it 'has the discounts current attributes prepopulated in the form' do
        expect(find_field('Name').value).to eq(@bulk_discount_1.name)
        expect(find_field('Percentage discount').value).to eq(@bulk_discount_1.percentage_discount.to_s)
        expect(find_field('Quantity threshold').value).to eq(@bulk_discount_1.quantity_threshold.to_s)
      end

      it 'when I change all of the information and I click submit I am redirected to the bulk discount show page and I see that the discounts attributes have been updated with a success notification' do
        fill_in 'Name', with: '5% off of 5'
        fill_in "Percentage discount", with: 0.05
        fill_in "Quantity threshold", with: 5

        click_button "Update #{@bulk_discount_1.name}"
        expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @bulk_discount_1))  
        expect(page).to have_content("Discount Successfully Updated")
        expect(page).to have_content('5% off of 5')
        expect(page).to have_content("Discount Percentage: 5.000%")
        expect(page).to have_content("Quantity Threshold: 5")

        expect(page).to_not have_content(@bulk_discount_1.name)
        expect(page).to_not have_content(@bulk_discount_1.percentage_discount)
        expect(page).to_not have_content(@bulk_discount_1.quantity_threshold)
      end

      it 'when I change some of the information and I click submit I am redirected to the bulk discount show page and I see that the discounts attributes have been updated with a success notification' do
        fill_in 'Name', with: '10% off of 10'
        fill_in "Percentage discount", with: 0.10
        fill_in "Quantity threshold", with: 10

        click_button "Update #{@bulk_discount_1.name}"
        expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @bulk_discount_1)) 
        expect(page).to have_content("Discount Successfully Updated")
        expect(page).to have_content('10% off of 10')
        expect(page).to have_content("Discount Percentage: 10.000%")
        expect(page).to have_content("Quantity Threshold: 10")

        expect(page).to_not have_content(@bulk_discount_1.name)
        expect(page).to_not have_content(@bulk_discount_1.percentage_discount)
        expect(page).to have_content(@bulk_discount_1.quantity_threshold)
      end

      it 'when I leave fields blank and I click submit I am redirected to the bulk discount edit page and I see a flash message' do
        fill_in 'Name', with: ''
        fill_in "Percentage discount", with: ''
        fill_in "Quantity threshold", with: ''

        click_button "Update #{@bulk_discount_1.name}"
        
        expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant, @bulk_discount_1))
        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("Percentage discount can't be blank")
        expect(page).to have_content("Quantity threshold can't be blank")
      end
    end
  end
end