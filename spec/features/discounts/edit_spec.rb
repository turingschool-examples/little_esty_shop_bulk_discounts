require 'rails_helper'

RSpec.describe 'Edit Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @discount1 = Discount.create!(percentage_discount: 20, quantity_threshold: 5, merchant_id: @merchant1.id)
    visit edit_merchant_discount_path(@merchant1, @discount1)
  end

  it "shows a flash message when the user does not fill out a section of the form" do
      fill_in "Percentage Discount", with: nil
      fill_in "Quantity Threshold", with: 6

      click_on "Submit"

      expect(page).to have_content("All fields must be completed, get your act together.")

      fill_in "Percentage Discount", with: 30
      fill_in "Quantity Threshold", with: nil

      click_on "Submit"

      expect(page).to have_content("All fields must be completed, get your act together.")
  end
end
