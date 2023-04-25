require 'rails_helper' 

RSpec.describe "bulk_discount#show page" do
  before :each do
    test_data
    visit merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)
  end

  it 'has quantity threshold and % discount' do
    expect(page).to have_content("Quantity Threshold: #{@bulk_discount_1.quantity_threshold} items")
    expect(page).to have_content("% Discount: #{@bulk_discount_1.percentage_discount}%")
  end

  it 'has edit button' do
    expect(page).to have_content("Edit Discount")

    click_link "Edit Discount"

    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant_1, @bulk_discount_1))
  end
end