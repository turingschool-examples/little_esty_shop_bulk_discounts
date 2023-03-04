require 'rails_helper'

describe 'bulk discounts edit page' do

  before do
    @merchant = create(:merchant)
    @bulk_discount= create(:bulk_discount, merchant_id: @merchant.id)
    edit_merchant_bulk_discount_path(@merchant, @bulk_discount)
  end

  it 'should have a header' do
    expect(page).to have_content("Edit Bulk Discount #{@bulk_discount.id}")  
  end

  it 'should start with prefilled form fields' do
    expect(page).to have_content('Percent discounted')
    expect(page).to have_field('Percent discounted', with: @bulk_discount.percent_discounted)
    expect(page).to have_content('Quantity threshold')
    expect(page).to have_field('Quantity threshold', with: @bulk_discount.quantity_threshold)
    expect(page).to have_button('Submit')
  end

end