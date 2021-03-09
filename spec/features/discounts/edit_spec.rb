require 'rails_helper' 

RSpec.describe 'merchant discount edit page' do 
  before :each do 
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @disc1 = Discount.create!(merchant_id: @merchant1.id, quantity: 10, percentage: 10)
    @disc2 = Discount.create!(merchant_id: @merchant1.id, quantity: 20, percentage: 20)

    visit "/merchant/#{@merchant1.id}/discounts/#{@disc1.id}/edit"
  end

  it 'shows the discount info and can change with valid input' do 
    visit "/merchant/#{@merchant1.id}/discounts/#{@disc1.id}/edit"
    within("#discount-info") do 
      page.fill_in 'quantity', with: 15
      page.fill_in 'percentage', with: 15
      click_on "Edit Discount"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/#{@disc1.id}")
    end
  end

  it 'shows the discount info and CANNOT change with invalid input' do 
    visit "/merchant/#{@merchant1.id}/discounts/#{@disc1.id}/edit"
    within("#discount-info") do 
      page.fill_in 'quantity', with: ""
      page.fill_in 'percentage', with: "" 
      
      click_on "Edit Discount"

      expect(page).to have_content("Quantity threshold for discount: Percentage off for discount:")
    end
  end
end