require 'rails_helper'

describe 'delete discount' do
  before do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @deleted_discount = @merchant1.discounts.create!(name: "nul", percent_off: 100, min_quantity: 1)
    @preserved_discount1 = @merchant1.discounts.create!(name: "saved", percent_off: 10, min_quantity: 3)
    @preserved_discount2 = @merchant1.discounts.create!(name: "saved 2", percent_off: 20, min_quantity: 5)
    visit merchant_discounts_path(@merchant1)
  end

  it 'has link to delete discount' do
    within "#discount-#{@deleted_discount.id}" do
      click_link "Delete this discount"
    end
      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts")
      expect(page).not_to have_content(@deleted_discount.name)
  end
end
