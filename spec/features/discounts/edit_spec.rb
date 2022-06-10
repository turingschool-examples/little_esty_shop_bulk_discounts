require "rails_helper"

RSpec.describe "Discount Edit Page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @discount1 = @merchant1.discounts.create!(threshold: 5, percentage: 5, name: "5% Discount")

    visit edit_merchant_discount_path(@merchant1.id, @discount1.id)
  end

  it "can edit/update an exisiting discount" do
    expect(page).to have_field("name", with: '5% Discount')
    expect(page).to have_field("threshold", with: 5)
    expect(page).to have_field("percentage", with: 5)

    fill_in "name", with: "New Name"
    fill_in "threshold", with: 10
    fill_in "percentage", with: 10
    click_on "Update Discount"

    expect(current_path).to eq(merchant_discount_path(@merchant1.id, @discount1.id))

    expect(page).to have_content("New Name:")
    expect(page).to have_content("Percent Discount: 10%")
    expect(page).to have_content("Threshold Quantity: 10")
  end

end
