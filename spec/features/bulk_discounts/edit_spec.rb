require 'rails_helper'

RSpec.describe "merchant/bulk_discount#edit page" do
  before :each do
    test_data
    visit edit_merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)
  end

  # it 'has a from with prefilled values' do
  #   expect(page).to have_content(@bulk_discount_1.name)
  #   expect(page).to have_content(@bulk_discount_1.percentage_discount)
  #   expect(page).to have_content(@bulk_discount_1.quantity_threshold)
  # end

  it 'fill in form correctly' do
    # save_and_open_page
    fill_in "name", with: "New Name"
    fill_in "quantity_threshold", with: 50
    fill_in "percentage_discount", with: 100
    click_button "Update"

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant_1, @bulk_discount_1))
    expect(page).to have_content("Discount Updated")
  end

  it 'fills in form incorrectly' do
    fill_in "name", with: ""
    fill_in "quantity_threshold", with: 50
    fill_in "percentage_discount", with: 100
    click_button "Update"

    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant_1, @bulk_discount_1))
    expect(page).to have_content("Update Failed")
  end
end