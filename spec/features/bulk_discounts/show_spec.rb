require 'rails_helper'
# 4: Merchant Bulk Discount Show

# As a merchant
# When I visit my bulk discount show page
# Then I see the bulk discount's quantity threshold and percentage discount

RSpec.describe 'bulk discount show page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Sallie Mae')
    @discount1a = @merchant1.bulk_discounts.create!(percentage_discount: 0.20, quantity_threshold: 10)
    visit merchant_bulk_discount_path(@merchant1, @discount1a)
  end
  it 'shows the bulk discounts quantity threshold and percentage discount' do
    expect(page).to have_content("#{@merchant1.name}'s Bulk Discount-#{@discount1a.id} Show Page")
    expect(page).to have_content("Percentage Discount: #{@discount1a.sanitized_percentage}%")
    expect(page).to have_content("Quantity Threshold: #{@discount1a.quantity_threshold}")
  end

  # 5: Merchant Bulk Discount Edit

  # As a merchant
  # When I visit my bulk discount show page
  # Then I see a link to edit the bulk discount
  # When I click this link
  # Then I am taken to a new page with a form to edit the discount
  # And I see that the discounts current attributes are pre-poluated in the form
  # When I change any/all of the information and click submit
  # Then I am redirected to the bulk discount's show page
  # And I see that the discount's attributes have been updated

  it 'has a link to the bulk discount edit page' do
    expect(page).to have_link('Edit Bulk Discount')

    click_link('Edit Bulk Discount')
    
    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1a))
  end
end