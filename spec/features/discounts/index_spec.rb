require 'rails_helper'

RSpec.describe "discounts index page" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Body Care')

    @discount_1 = Discount.create!(percent_discount: 10, quantity: 15, merchant_id: @merchant1.id)
    @discount_2 = Discount.create!(percent_discount: 15, quantity: 30, merchant_id: @merchant1.id)
    @discount_3 = Discount.create!(percent_discount: 30, quantity: 40, merchant_id: @merchant2.id)
  end

  it "can show all discounts with percent and quantity on the discounts index page" do
    visit merchant_discounts_path(@merchant1)

    expect(page).to have_content("#{@discount_1.percent_discount} percent off when #{@discount_1.quantity} items are bought.")
    expect(page).to have_content("#{@discount_2.percent_discount} percent off when #{@discount_2.quantity} items are bought.")
    expect(page).to have_no_content("#{@discount_3.percent_discount} percent off when #{@discount_3.quantity} items are bought.")
  end

  it "shows a link for each bulk discount displayed" do
    visit merchant_discounts_path(@merchant1)

    expect(page).to have_link("Discount", :href=>"/merchant/#{@merchant1.id}/discounts/#{@discount_1.id}")
    expect(page).to have_link("Discount", :href=>"/merchant/#{@merchant1.id}/discounts/#{@discount_2.id}")
  end

  it "can show the upcoming 3 holidays in the US" do
    visit merchant_discounts_path(@merchant1)

    expect(page).to have_content("Upcoming Holidays")
    expect(page).to have_content("Memorial Day, 2021-05-31 Independence Day, 2021-07-05 Labour Day, 2021-09-06")
  end

  it "shows a link to create a discount is displayed" do
    visit merchant_discounts_path(@merchant1)

    expect(page).to have_link("Create a Discount")
  end

  it "the link goes to the create a new form page" do
    visit merchant_discounts_path(@merchant1)

    expect(page).to have_link("Create a Discount")

    click_link "Create a Discount"

    visit new_merchant_discount_path(@merchant1)

    expect(current_path).to eq(new_merchant_discount_path(@merchant1))
  end
end
