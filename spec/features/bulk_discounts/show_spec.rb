require 'rails_helper'

describe "merchant bulk discount show" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @discount1 = BulkDiscount.create!(percent_discount: 20, qty_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(percent_discount: 30, qty_threshold: 15, merchant_id: @merchant1.id)

    visit merchant_bulk_discount_path(@merchant1, @discount1)
  end

  it "shows percentage and quantity thresholds" do
    expect(page).to have_content(@discount1.percent_discount)
    expect(page).to have_content(@discount1.qty_threshold)
  end

  it "shows link to edit discount" do
    click_link "Edit Discount"
    expect(current_path).to eq()
  end

# As a merchant
# When I visit my bulk discount show page
# Then I see a link to edit the bulk discount
# When I click this link
# Then I am taken to a new page with a form to edit the discount
# And I see that the discounts current attributes are pre-poluated in the form
# When I change any/all of the information and click submit
# Then I am redirected to the bulk discount's show page
# And I see that the discount's attributes have been updated
end
