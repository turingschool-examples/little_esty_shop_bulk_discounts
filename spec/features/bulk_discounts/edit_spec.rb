require 'rails_helper'

RSpec.describe 'Bulk Discount Edit Page', type: :feature do
  before :each do
    @merchant = Merchant.create!(name: 'Hair Care')
    @discount_1 = @merchant.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 20)
    @discount_2 = @merchant.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 30)
    @discount_3 = @merchant.bulk_discounts.create!(percentage_discount: 40, quantity_threshold: 40)
    visit merchant_bulk_discount_path(@merchant, @discount_1)
  end
  describe "As a merchant" do
    describe "When I click the edit link" do
      it "I am taken to a new page with a form to edit the discount" do
        click_link("Edit Discount")
        expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant, @discount_1))
        expect(page).to have_field("Percentage discount")
        expect(page).to have_field("Quantity threshold")
        expect(page).to have_button("Update Discount")
      end

      it "And I see that the discounts current attributes are pre-poluated in the form" do
        click_link("Edit Discount")
        expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant, @discount_1))
        expect(page).to have_field("Percentage discount", with: 20.0)
        expect(page).to have_field("Quantity threshold", with: 20)
      end

      it "When I fill in the form with valid data Then I am redirected back to the bulk discount show page And I see attributes updated" do
        click_link("Edit Discount")
        fill_in "Percentage discount", with: 50
        click_button "Update Discount"
        expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @discount_1))
      end

      it "display a flash message that the discount wasn't updated due to missing info" do
        click_link("Edit Discount")
        fill_in "Percentage discount", with: ""
        click_button "Update Discount"
        expect(page).to have_content("Discount not updated: Required information missing.")
        expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant, @discount_1))
        fill_in "Percentage discount", with: 50
        fill_in "Quantity threshold", with: ""
        click_button "Update Discount"
        expect(page).to have_content("Discount not updated: Required information missing.")
        expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant, @discount_1))
      end

      it "display a flash message that the discount wasn't updated due to invalid info" do
        click_link("Edit Discount")
        fill_in "Percentage discount", with: "fifty"
        click_button "Update Discount"
        expect(page).to have_content("Discount not updated: Required information missing.")
        expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant, @discount_1))
      end
    end
  end
end