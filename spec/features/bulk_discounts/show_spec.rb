require 'rails_helper'

describe 'Merchant Bulk Discount Show' do
  before(:each) do
    @merchant1 = Merchant.create!(name: 'Merchant 1')
    @bulk_discount1 = @merchant1.bulk_discounts.create!(merchant_id: @merchant1.id, threshold: 5, discount_percent: 10)
    @bulk_discount2 = @merchant1.bulk_discounts.create!(merchant_id: @merchant1.id, threshold: 15, discount_percent: 20)
    visit merchant_bulk_discount_path(@merchant1, @bulk_discount1)
  end

  describe "As a merchant, when I visit the page" do
    it "displays the threshold and percent discount for the bulk discount" do
      expect(page).to have_content(@bulk_discount1.threshold)
      expect(page).to have_content(@bulk_discount1.discount_percent)

      expect(page).to_not have_content(@bulk_discount2.threshold)
      expect(page).to_not have_content("Discount # #{@bulk_discount2.discount_percent}")
    end

    it "has a link to edit the bulk discount" do
      expect(page).to have_link("Edit this Discount")
    end

    it "when I click the edit link, I am taken to a form to edit the discount" do
      click_link("Edit this Discount")
      expect(current_path).to eq edit_merchant_bulk_discount_path(@merchant1, @bulk_discount1)
    end
  end
end


