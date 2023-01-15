require 'rails_helper'
RSpec.describe 'merchants bulk discount index' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @discount1a = @merchant1.bulk_discounts.create!(percentage_discount: 0.20, quantity_threshold: 10)
    @discount1b = @merchant1.bulk_discounts.create!(percentage_discount: 0.30, quantity_threshold: 12)
    @discount1c = @merchant1.bulk_discounts.create!(percentage_discount: 0.15, quantity_threshold: 25)
    visit merchant_bulk_discounts_path(@merchant1)
  end
  # 1: Merchant Bulk Discounts Index
  
  # As a merchant
  # When I visit my merchant dashboard
  # Then I see a link to view all my discounts
  # When I click this link
  # Then I am taken to my bulk discounts index page
  # Where I see all of my bulk discounts including their
  # percentage discount and quantity thresholds
  # And each bulk discount listed includes a link to its show page
  it 'shows all bulk discounts, their attributes, and a link to their show page' do
    expect(page).to have_content("#{@merchant1.name}'s Bulk Discount Index")

    within "#bulk-discount-#{@discount1a.id}" do
      expect(page).to have_content("Bulk Discount #{@discount1a.id}")
      expect(page).to have_content("#{(@discount1a.percentage_discount*100).to_int}%")
      expect(page).to have_content(@discount1a.quantity_threshold)
      expect(page).to have_link("To Bulk Discount #{@discount1a.id} Show Page")
    end

    within "#bulk-discount-#{@discount1b.id}" do
      expect(page).to have_content("Bulk Discount #{@discount1b.id}")
      expect(page).to have_content("#{(@discount1b.percentage_discount*100).to_int}%")
      expect(page).to have_content(@discount1b.quantity_threshold)
      expect(page).to have_link("To Bulk Discount #{@discount1b.id} Show Page")
    end

    within "#bulk-discount-#{@discount1c.id}" do
      expect(page).to have_content("Bulk Discount #{@discount1c.id}")
      expect(page).to have_content("#{(@discount1c.percentage_discount*100).to_int}%")
      expect(page).to have_content(@discount1c.quantity_threshold)
      expect(page).to have_link("To Bulk Discount #{@discount1c.id} Show Page")
    end
  end

  it 'redirects to bulk discount show page when you click the link' do
    within "#bulk-discount-#{@discount1a.id}" do
      click_link("To Bulk Discount #{@discount1a.id} Show Page")
    end

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1a))
  end
