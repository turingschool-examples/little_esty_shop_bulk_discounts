require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount update' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Hair Care')
    @discount_1 = BulkDiscount.create!(name:"small discount", percentage_discount: 0.10, quantity_threshold: 10, merchant_id: @merchant_1.id)
    @discount_2 = BulkDiscount.create!(name:"medium discount", percentage_discount: 0.15, quantity_threshold: 14, merchant_id: @merchant_1.id)
    @discount_3 = BulkDiscount.create!(name:"huge discount", percentage_discount: 0.20, quantity_threshold: 20, merchant_id: @merchant_1.id)
  end

  describe "When I visit my bulk discount show page" do
    it "Then I see a link to edit the discount" do
      visit merchant_bulk_discount_path(@merchant_1, @discount_1)

      expect(page).to have_link("edit discount")
    end

    it "When I click this link Then I am taken to a new page where I see a form to edit the bulk discount" do
       visit merchant_bulk_discount_path(@merchant_1, @discount_1)

       click_link("edit discount")
       expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant_1, @discount_1))
    end

    it "And I see that the discounts current attributes are pre-poluated in the form" do
      visit edit_merchant_bulk_discount_path(@merchant_1, @discount_1)
      expect(find_field(:name).value).to eq(@discount_1.name.to_s)
      # expect(find_field(:quantity_threshold)).value).to eq(@discount_1.quantity_threshold)
      expect(find_field(:percentage_discount).value.to_i).to eq(@discount_1.discount_int)
    end

    it "When I fill in the form with valid data and i click submit and I am redirected back to the bulk discount index" do
      visit edit_merchant_bulk_discount_path(@merchant_1, @discount_1)

      expect(current_path).to eq("/merchant/#{@merchant_1.id}/bulk_discounts/#{@discount_1.id}/edit")
      fill_in :name, :with => "edited-small discount"
      fill_in :percentage_discount, :with => 13
      fill_in :quantity_threshold, :with => 8
      click_button('Submit')
      expect(current_path).to eq("/merchant/#{@merchant_1.id}/bulk_discounts")
      within("#discount-#{@discount_1.id}") do
        expect(page).to have_content("edited-small discount")
        expect(page).to have_content("13")
        expect(page).to have_content("8")
      end
    end

    it "When I fill in the form with invalid data and i click submit and the form is not allowed to submit" do
      visit edit_merchant_bulk_discount_path(@merchant_1, @discount_1)

      expect(current_path).to eq("/merchant/#{@merchant_1.id}/bulk_discounts/#{@discount_1.id}/edit")
      fill_in :name, :with => "edited-small discount"
      fill_in :percentage_discount, :with => 131
      fill_in :quantity_threshold, :with => 8
      click_button('Submit')
      expect(page).to have_content("Unable to update bulk discount!")
    end
  end
end
