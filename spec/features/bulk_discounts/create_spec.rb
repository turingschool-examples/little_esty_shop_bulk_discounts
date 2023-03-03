require 'rails_helper' 

RSpec.describe 'Bulk Discount Create Page', type: :feature do
  before :each do
    @merchant = Merchant.create!(name: 'Hair Care')
    @discount_1 = @merchant.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 20)
    @discount_2 = @merchant.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 30)
    @discount_3 = @merchant.bulk_discounts.create!(percentage_discount: 40, quantity_threshold: 40)
    visit merchant_dashboard_index_path(@merchant)
    click_link("My Discounts")
    click_link("Create New Discount")
  end
  describe "I see a link to create a new discount" do
    it "when I click the link I am taken to a new page with a form to create a new bulk discount" do
      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant))
      expect(page).to have_content("Create New Discount")
      expect(page).to have_field("Percentage discount")
      expect(page).to have_field("Quantity threshold")
      expect(page).to have_button("Create Discount")
    end

    it "When I fill in the form with valid data Then I am redirected back to the bulk discount index And I see my new bulk discount listed" do
      fill_in "Percentage discount", with: 50
      fill_in "Quantity threshold", with: 50
      click_button "Create Discount"
      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
      discount = BulkDiscount.last
      within "#discounts-#{discount.id}" do
        expect(page).to have_content("Percentage off: %50.0")
        expect(page).to have_content("Minimum number of Items: 50")
      end
    end
  end
end
