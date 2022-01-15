require "rails_helper"

RSpec.describe 'bulk discounts edit' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @bd_1 = BulkDiscount.create!(percentage: 20, threshold: 10, merchant_id: @merchant1.id)
    @bd_2 = BulkDiscount.create!(percentage: 25, threshold: 15, merchant_id: @merchant1.id)
  end

  it "renders edit page with correct pre-populated information" do
    visit "/merchant/#{@merchant1.id}/discounts/#{@bd_1.id}"
    click_link 'Edit'

    expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/#{@bd_1.id}/edit")
    expect(page).to have_field("Percentage", :value => 20)
    expect(page).to have_field("Threshold", :value => 15)
  end
end
