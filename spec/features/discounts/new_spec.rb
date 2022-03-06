require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount New' do
  before(:each) do
    @merchant1 = create(:merchant)

    @discount1 = create(:discount, merchant_id: @merchant1.id )
    @discount2 = create(:discount, merchant_id: @merchant1.id )
    @discount3 = create(:discount, merchant_id: @merchant1.id )
    @discount4 = create(:discount, merchant_id: @merchant1.id )
  end

  describe 'us3' do

    it 'has a form where I fill in data and am redirected back to discount index where I see new discount' do
      visit new_merchant_discount_path(@merchant1)
      expect(current_path).to eq(new_merchant_discount_path(@merchant1))

      within 'div.new_discount_form' do
        fill_in('Name', with: 'Small Discount')
        fill_in('Discount Percentage', with: 35)
        fill_in('Threshold', with: 45)
        click_on "Save"
      end
      expect(current_path).to eq(merchant_discounts_path(@merchant1))
      expect(page).to have_content('Small Discount Has Been Created!')
      expect(page).to have_content('Small Discount')
    end
    it 'warns me if I do not fill out all fields' do
      visit new_merchant_discount_path(@merchant1)
      expect(current_path).to eq(new_merchant_discount_path(@merchant1))

      within 'div.new_discount_form' do
        fill_in('Name', with: 'Sam')
        fill_in('Threshold', with: 45)
        click_on "Save"
      end
      expect(current_path).to eq(new_merchant_discount_path(@merchant1))
      expect(page).to have_content("Error: Percent discount can't be blank")
    end
  end
end
