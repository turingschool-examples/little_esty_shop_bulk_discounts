require 'rails_helper'

describe "merchant bulk discounts" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Pets R Us')

    @discount1 = BulkDiscount.create!(percentage_discount: 0.25, quantity_threshold: 50, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(percentage_discount: 0.15, quantity_threshold: 25, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(percentage_discount: 0.10, quantity_threshold: 10, merchant_id: @merchant2.id)
    @discount4 = BulkDiscount.create!(percentage_discount: 0.05, quantity_threshold: 5, merchant_id: @merchant2.id)
  end

  it "I see all of my bulk discounts including their percentage discount and quantity thresholds" do
    visit merchant_bulk_discounts_path(@merchant1)

    expect(page).to have_content('25%')
    expect(page).to have_content("#{@discount1.quantity_threshold}")
    expect(page).to have_content('15%')
    expect(page).to have_content("#{@discount2.quantity_threshold}")
    expect(page).to_not have_content("#{@discount3.percentage_discount}")
    expect(page).to_not have_content("#{@discount4.percentage_discount}")
  end

  it "I see each bulk discount listed includes a link to it's show page" do
    visit merchant_bulk_discounts_path(@merchant1)
    
    expect(page).to have_link("#{@discount1.id}")
    expect(page).to have_link("#{@discount2.id}")

    click_link(@discount1.id)
    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
  end

  end
