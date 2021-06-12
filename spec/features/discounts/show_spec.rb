require 'rails_helper'

RSpec.describe 'merchant discounts index' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @discount1 = Discount.create!(percentage_discount: 0.25, quantity_threshold: 5, merchant_id: @merchant1.id)
    @discount2 = Discount.create!(percentage_discount: 0.50, quantity_threshold: 10, merchant_id: @merchant1.id)

    visit merchant_discount_path(@merchant1, @discount1)
  end
  #   Merchant Bulk Discount Show

  # As a merchant
  # When I visit my bulk discount show page
  # Then I see the bulk discount's quantity threshold and percentage discount
  it 'shows the discounts attributes' do
    expect(page).to have_content(@discount1.id)
    expect(page).to have_content(@discount1.percentage_discount)
    expect(page).to have_content(@discount1.quantity_threshold)
  end
  #   Merchant Bulk Discount Edit

  # As a merchant
  # When I visit my bulk discount show page
  # Then I see a link to edit the bulk discount
  # When I click this link
  # Then I am taken to a new page with a form to edit the discount
  # And I see that the discounts current attributes are pre-poluated in the form
  # When I change any/all of the information and click submit
  # Then I am redirected to the bulk discount's show page
  # And I see that the discount's attributes have been updated
  it 'has a button to edit a discount' do
    expect(page).to have_link('Edit Discount')

    click_link 'Edit Discount'

    expect(current_path).to eq(edit_merchant_discount_path(@merchant1, @discount1))
  end
end
