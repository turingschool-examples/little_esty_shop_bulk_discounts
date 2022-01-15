require "rails_helper"

RSpec.describe 'bulk discounts show page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @bd_1 = BulkDiscount.create!(percentage: 20, threshold: 10, merchant_id: @merchant1.id)
    @bd_2 = BulkDiscount.create!(percentage: 25, threshold: 15, merchant_id: @merchant1.id)
    visit "/merchant/#{@merchant1.id}/discounts"
  end
  it "text" do
    click_link "#{@bd_1.id}"

    expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/#{@bd_1.id}")
    expect(page).to have_content("Id: #{@bd_1.id}")
    expect(page).to have_content("Discount: #{@bd_1.percentage}")
    expect(page).to have_content("Threshold: #{@bd_1.threshold}")
  end
end
