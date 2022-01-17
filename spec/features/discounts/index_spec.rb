require 'rails_helper'

describe 'discount index' do
  before do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @discount_a = @merchant1.discounts.create!(min_quantity: 10, percent_off: 20, name: "first discount")
    @discount_b = @merchant1.discounts.create!(min_quantity: 15, percent_off: 30, name: "second discount")

    visit merchant_discounts_path(@merchant1)
  end

  it 'displays all discounts' do
    within "#discount-list" do
      expect(page).to have_content(@discount_a.name)
      expect(page).to have_content("Minimum purchase threshold: #{@discount_a.min_quantity}")
      expect(page).to have_content("Percentage discount: #{@discount_a.percent_off}")
      expect(page).to have_content(@discount_b.name)
      expect(page).to have_content("Minimum purchase threshold: #{@discount_b.min_quantity}")
      expect(page).to have_content("Percentage discount: #{@discount_b.percent_off}")
    end
  end

  it 'has a link for each corresponding discount' do
    within "#discount-list" do
      within "#discount-#{@discount_b.id}" do
        expect(page).to have_link("View #{@discount_b.name} info")
      end
    end
  end

  it 'has a link to create a new discount' do
    expect(page).to have_link("Create New Discount")
  end

  it 'Create new discount link leads to new item form' do
    click_link "Create New Discount"
    expect(current_path).to eq(new_merchant_discount_path(@merchant1))
  end
end
