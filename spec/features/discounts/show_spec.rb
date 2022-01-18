require 'rails_helper'

describe 'discount show page' do
  before do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @discount_a = @merchant1.discounts.create!(min_quantity: 10, percent_off: 20, name: "first discount")
    @discount_b = @merchant1.discounts.create!(min_quantity: 15, percent_off: 30, name: "second discount")

    visit merchant_discounts_path(@merchant1)
  end

  it 'path exists' do
    within '#discount-list' do
      within "#discount-#{@discount_b.id}" do
        click_link ("View #{@discount_b.name} info")
        expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/#{@discount_b.id}")
      end
    end
  end

  it 'shows all discount info' do
    visit merchant_discount_path(@merchant1, @discount_a)
    expect(page).to have_content(@discount_a.name)
    expect(page).to have_content("Quantity threshold: #{@discount_a.min_quantity}")
    expect(page).to have_content("Percent off: #{@discount_a.percent_off}")
  end
end
