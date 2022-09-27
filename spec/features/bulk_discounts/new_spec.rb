require 'rails_helper'

RSpec.describe 'Bulk Discount creation form: as a merchant' do
  describe "when I visit the page to create a new bulk discount " do

    before(:each) do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      visit new_merchant_bulk_discount_path(@merchant1)
    end

    it "has a form to create a new discount" do
      expect(page).to have_field(:threshold)
      expect(page).to have_field(:discount_percent)
    end

    describe "when I fill out that form with the required information, and click submit" do
      before(:each) do
        fill_in "discount_percent", with: "50"
        fill_in "threshold", with: "100"
        click_on "Create New Discount"
      end

      it "I am redirected to the index page" do
        expect(current_path).to eq merchant_bulk_discounts_path(@merchant1)
      end

      it "And I see the new bulk discount" do
        expect(page).to have_content(100)
        expect(page).to have_content(50)
      end
    end

    describe "when I do not correctly fill out the page" do
      before(:each) do
        fill_in "discount_percent", with: "50"
        click_on "Create New Discount"
      end
      it "I am redirected to the new form again" do
        expect(current_path).to eq new_merchant_bulk_discount_path(@merchant1)
      end

      xit "I see a message telling me of an error" do
        expect(page).to have_content "Error Message"
      end
    end
  end
end
