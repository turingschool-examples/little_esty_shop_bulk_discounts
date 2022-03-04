require 'rails_helper'

describe "merchant bulk discount show" do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @discount1 = BulkDiscount.create!(percent_discount: 20, qty_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(percent_discount: 30, qty_threshold: 15, merchant_id: @merchant1.id)

    visit merchant_bulk_discount_path(@merchant1, @discount1)
  end

  it "shows all discounts with percentage and quanity thresholds" do

  end
end
