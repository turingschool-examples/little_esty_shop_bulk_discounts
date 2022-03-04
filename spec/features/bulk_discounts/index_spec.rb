require 'rails_helper'

describe "merchant bulk discounts index" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')


    @discount1 = BulkDiscount.create!(percent_discount: 20, qty_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(percent_discount: 30, qty_threshold: 15, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(percent_discount: 40, qty_threshold: 20, merchant_id: @merchant1.id)

    visit merchant_bulk_discounts_path(@merchant1)
  end

  it "shows all discounts with percentage and quanity thresholds" do

    expect(page).to have_content(@discount1.percent_discount)
    expect(page).to have_content(@discount1.qty_threshold)
    expect(page).to have_content(@discount1.id)
    expect(page).to have_content(@discount2.percent_discount)
    expect(page).to have_content(@discount2.qty_threshold)
    expect(page).to have_content(@discount2.id)
    expect(page).to have_content(@discount3.percent_discount)
    expect(page).to have_content(@discount3.qty_threshold)
    expect(page).to have_content(@discount3.id)
  end

  it "includes link to discount show page" do
    save_and_open_page
    click_link("#{@discount1.id}")
    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
  end
end
