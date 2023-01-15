require 'rails_helper'

RSpec.describe 'bulk items show page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Foot Care')

    @discount1 = BulkDiscount.create!(percent_discount: 20, quantity_threshold: 30, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(percent_discount: 30, quantity_threshold: 50, merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(percent_discount: 15, quantity_threshold: 20, merchant_id: @merchant2.id)

    visit merchant_bulk_discount_path(@merchant1, @discount1)
  end

  it 'contains a discounts quantity threshold and percent discount' do

  end
end