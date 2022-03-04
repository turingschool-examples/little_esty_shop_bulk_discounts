require 'rails_helper'

describe "merchant bulk discounts index" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @discount1 = BulkDiscount.create!(percent_discount: 20, qty_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(percent_discount: 30, qty_threshold: 15, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(percent_discount: 40, qty_threshold: 20, merchant_id: @merchant1.id)

    visit merchant_bulk_discounts_path(@merchant1)
  end

  it "shows all discounts with percentage and quantity thresholds" do
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
    click_link("#{@discount1.id}")
    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
  end

  it "includes Upcoming holidays section" do
    expect(page).to have_content("Upcoming Holidays")
  end

  it "lists next three holidays" do
    3.times do |index|
      within "#holiday-#{index}" do
        expect(page).to have_content("Date")
      end
    end
  end

  it "includes link to create new discount" do
    expect(page).to have_link("Create New Discount")
  end

  it "includes link to delete discount - which in fact deletes that shit" do
    expect(page).to have_content(@discount3.id)

    within("#discount-#{@discount3.id}") do
      expect(page).to have_button("Delete Discount")
      click_button "Delete Discount"
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    expect(page).to_not have_content(@discount3.id)
  end
end
