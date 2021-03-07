require 'rails_helper'

RSpec.describe 'A merchants discount show page' do 
  before :each do 
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @disc1 = Discount.create!(merchant_id: @merchant1.id, quantity: 10, percentage: 10)
    
    visit "/merchant/#{@merchant1.id}/discounts/#{@disc1.id}"
  end

  it 'should show the merchant name and discount info' do 
    within("#discount-info") do 
      expect(page).to have_content("Merchant Name: #{@merchant1.name}")
      expect(page).to have_content("Discount id# #{@disc1.id}")
      expect(page).to have_content("Quantity Threshold: #{@disc1.quantity}")
      expect(page).to have_content("Percentage Discount: #{@disc1.percentage}")
      
    end
  end
end