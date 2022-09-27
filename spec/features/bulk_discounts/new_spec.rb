require 'rails_helper'

RSpec.describe 'Bulk Discount creation form: as a merchant' do
  describe "when I visit the page to create a new bulk discount " do
    before(:each) do
      visit new_merchant_bulk_discount_path
    end
    it "has a form to create a new discount" do
      expect(page).to have_field(:threshold)
      expect(page).to have_field(:discount_percent)
    end

    describe "when I fill out that form with the required information, and click submit" do
      it "I am redirected to the index page" do
      end

      it "And I see the new bulk discount" do
      end
    end

    describe "when I do not correctly fill out the page" do
      it "I am not redirected" do
      end

      it "And I see a message telling me of an error" do
      end
    end  
  end
end
