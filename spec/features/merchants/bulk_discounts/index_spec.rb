require 'rails_helper'

RSpec.describe 'Merchant Bulk Discounts Index' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Putney Generaly Store')
    @discount1 = create(:discount, merchant_id: @merchant1)
    @discount2 = create(:discount, merchant_id: @merchant1)
    @discount3 = create(:discount, merchant_id: @merchant1)
  end
end