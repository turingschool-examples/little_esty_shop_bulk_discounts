require 'rails_helper'

describe 'bulk discounts show page' do
  before do
    @merchant = create(:merchant)
    @bulk_discount1 = create(:bulk_discount, merchant_id: @merchant.id)
    @bulk_discount2 = create(:bulk_discount, merchant_id: @merchant.id)
    visit merchant_bulk_discount_path(@merchant, @bulk_discount1)
  end
  it 'shows the quantity threshold and percentage discount for a bulk_discount (1)' do
    expect(page).to_not have_content("Id: #{@bulk_discount2.id}")
    expect(page).to have_content("Id: #{@bulk_discount1.id}")
    expect(page).to have_content("Threshold: #{@bulk_discount1.quantity_threshold}")
    expect(page).to have_content("Percentage Discount: #{@bulk_discount1.percent_discounted}")
  end

  it 'shows the quantity threshold and percentage discount for a bulk_discount (2)' do
    visit merchant_bulk_discount_path(@merchant, @bulk_discount2)
    expect(page).to_not have_content("Id: #{@bulk_discount1.id}")
    expect(page).to have_content("Id: #{@bulk_discount2.id}")
    expect(page).to have_content("Threshold: #{@bulk_discount2.quantity_threshold}")
    expect(page).to have_content("Percentage Discount: #{@bulk_discount2.percent_discounted}")
  end

  it 'has a link to an edit page for a bulk_discount (1)' do
    expect(page).to have_link("Edit")
    click_link("Edit")
    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant, @bulk_discount1))
  end

  it 'has a link to an edit page for a bulk_discount (2)' do
    visit merchant_bulk_discount_path(@merchant, @bulk_discount2)
    click_link("Edit")
    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant, @bulk_discount2))
  end

end