require 'rails_helper'

RSpec.describe 'bulk discounts index page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Foot Care')

    @discount1 = BulkDiscount.create!(percent_discount: 20, quantity_threshold: 30, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(percent_discount: 30, quantity_threshold: 50, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(percent_discount: 15, quantity_threshold: 20, merchant_id: @merchant2.id)

    visit merchant_bulk_discounts_path(@merchant1)
  end

  it 'contains all of that merchants discounts including their percent discount and quantity threshold' do
    within("#discount_#{@discount1.id}") do
      expect(page).to have_content("Discount: #{@discount1.percent_discount}")
      expect(page).to have_content("Quantity Threshold: #{@discount1.quantity_threshold}")
      expect(page).to_not have_content("Discount: #{@discount2.percent_discount}")
      expect(page).to_not have_content("Quantity Threshold: #{@discount2.quantity_threshold}")

    end
  end

  it 'contains links to each merchant discounts show page' do
    within("#discount_#{@discount1.id}") do
      expect(page).to have_link("Discount ##{@discount1.id}")
      expect(page).to_not have_link("Discount ##{@discount2.id}")
    end

    within("#discount_#{@discount2.id}") do
      expect(page).to have_link("Discount ##{@discount2.id}")
      expect(page).to_not have_link("Discount ##{@discount1.id}")

      click_link("Discount ##{@discount2.id}")
    end

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount2))
  end

  it 'contains a link to create a new bulk discount' do
    expect(page).to have_link("Create New Discount")

    click_link("Create New Discount")

    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
  end

  it 'contains a link to delete a new bulk discount' do
    within ("#discount_#{@discount1.id}") do
      expect(page).to have_link("Delete Discount #{@discount1.id}")

      click_link("Delete Discount #{@discount1.id}")
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))

    within("#discounts") do
      expect(page).to_not have_content(@discount1.id)
    end
  end
end
