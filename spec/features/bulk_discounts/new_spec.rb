require 'rails_helper'

RSpec.describe BulkDiscount, type: :feature do
  context "new discount form" do
  end
  before(:each) do
    @merchant1 = Merchant.create!(name: 'I Care')
    @discount1 = @merchant1.bulk_discounts.create!(percent: 10, threshold: 100)
    @discount2 = @merchant1.bulk_discounts.create!(percent: 20, threshold: 300)
    @discount3 = @merchant1.bulk_discounts.create!(percent: 30, threshold: 400)
    
    visit "/merchant/#{@merchant1.id}/bulk_discounts/new"
  end

  it "redirects back to bulk discount index when form completed with valid data" do
save_and_open_page
    fill_in :percent, with: '40'
    fill_in :threshold, with: '600'
    click_button "Submit"

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    expect(page).to have_content('New Discount Created')
    expect(page).to have_content("40% off if 600 items purchased")
  end
end