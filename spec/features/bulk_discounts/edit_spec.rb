require 'rails_helper'

RSpec.describe 'Bulk Discount edit form: as a merchant' do
  describe "when I visit the page to edit a bulk discount" do
    before(:each) do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @bulk_discount1 = @bulk_discount1 = BulkDiscount.create!(merchant_id: @merchant1.id, threshold: 5, discount_percent: 10)
      @bulk_discount2 = @merchant1.bulk_discounts.create!(merchant_id: @merchant1.id, threshold: 15, discount_percent: 20)
      visit edit_merchant_bulk_discount_path(@merchant1, @bulk_discount1)
    end

    it "the page displays a form to change the attributes of the discount" do
      expect(page).to have_field(:discount_percent)
      expect(page).to have_field(:threshold)
    end

    xit "the fields are pre-populated with the current information" do
      expect(page).to have_content(@bulk_discount1.discount_percent)
      expect(page).to have_content(@bulk_discount1.threshold)
      expect(page).to_not have_content(bulk_discount2.threshold)
    end

    describe "when I change any/all of the information and click submit" do
      before(:each) do
        fill_in "discount_percent", with: "40"
        fill_in "threshold", with: "150"
        click_button "Confirm Changes"
      end

      it "I am redirected to the bulk discount show page" do
        expect(current_path).to eq merchant_bulk_discount_path(@merchant1, @bulk_discount1)
      end

      it "I see that the values have changed" do
        expect(page).to have_content(150)
        expect(page).to have_content(40)
      end
    end

    describe "when I fill in invalid or nil information" do
      before(:each) do
        fill_in "threshold", with: ""
        click_button "Confirm Changes"
      end
      it "redirects me back to the edit page" do
        expect(current_path).to eq edit_merchant_bulk_discount_path(@merchant1, @bulk_discount1)
      end
    end
  end
end