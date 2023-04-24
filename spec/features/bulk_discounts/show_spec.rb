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
end