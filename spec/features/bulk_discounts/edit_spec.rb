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
    expect(page).to have_field("Percentage", with: 20)
    expect(page).to have_field("Threshold", with: 10)
  end

  it "updates discount information" do
    visit "/merchant/#{@merchant1.id}/discounts/#{@bd_1.id}/edit"
    fill_in 'Percentage', with: 21
    fill_in 'Threshold', with: 11
    click_button 'Submit'

    expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/#{@bd_1.id}")
    expect(page).to have_content("Discount: 21%")
    expect(page).to have_content("Threshold: 11")
    expect(page).to_not have_content("Percentage: 20")
    expect(page).to_not have_content("Threshold: 10")
  end
end
