require 'rails_helper'

describe "merchant bulk discount show page" do
  include ApplicationHelper
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @discount1 = BulkDiscount.create!(percentage_discount: 0.25, quantity_threshold: 50, merchant_id: @merchant1.id)
  end

  it "I see the bulk discount's quanity threshold and percentage discount" do
    visit merchant_bulk_discount_path(@merchant1, @discount1)
  
    expect(page).to have_content("Bulk Discount: #{@discount1.id}")

    expect(page).to have_content("Percentage discount: #{float_to_percent(@discount1.percentage_discount)}")
    expect(page).to have_content("Quantity threshold: #{@discount1.quantity_threshold}")
  end

  it "I see a link to edit the bulk discount, when I click this link I'm taken to a new page with a form to edit the discount and I see that the discounts current attributes are pre-populated" do
    visit merchant_bulk_discount_path(@merchant1, @discount1)

    click_link("Edit bulk discount #{@discount1.id}")

    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1))
    expect(page).to have_field("Percentage discount", with: "#{@discount1.percentage_discount}")
    expect(page).to have_field("Quantity threshold", with: "#{@discount1.quantity_threshold}")
  end

  it "I change any/all of the information and click submit, then I am redirected to the bulk discount's show page and I see that the discount's attributes have been udpated" do
    visit edit_merchant_bulk_discount_path(@merchant1, @discount1)

    fill_in("Percentage discount", with: 0.50)
    click_button("Submit")
    
    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
    expect(page).to have_content("Quantity threshold: #{@discount1.quantity_threshold}")
    expect(page).to have_content("Percentage discount: #{float_to_percent(0.50)}")
  end

  it "I enter invalid information and click submit, the page is rendered again and an error message is displayed" do
    visit edit_merchant_bulk_discount_path(@merchant1, @discount1)

    fill_in("Percentage discount", with: '')
    click_button("Submit")

    expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/#{@discount1.id}")
    expect(page).to have_content("Invalid input")
  end
end