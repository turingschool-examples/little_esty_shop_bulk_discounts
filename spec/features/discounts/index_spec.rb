require 'rails_helper' 

RSpec.describe 'merchant discounts index' do 
  before :each do 
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @disc1 = Discount.create!(merchant_id: @merchant1.id, quantity: 10, percentage: 10)
    @disc2 = Discount.create!(merchant_id: @merchant1.id, quantity: 20, percentage: 20)

    visit "/merchant/#{@merchant1.id}/discounts"
  end

  it 'shows the merchant name at the top' do 
    expect(page).to have_content("#{@merchant1.name}'s Discounts")
  end

  it 'shows all the discounts and their quantity threshold and percentage discounts' do 
    within("#discount-#{@disc1.id}") do 
      expect(page).to have_content("Link to discount page: Discount id# #{@disc1.id}")
      expect(page).to have_content("Quantity Threshold: #{@disc1.quantity}")
      expect(page).to have_content("Percentage Discount: #{@disc1.percentage}")

      click_link "Discount id# #{@disc1.id}"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/#{@disc1.id}")
    end

    visit "/merchant/#{@merchant1.id}/discounts"

    within("#discount-#{@disc2.id}") do 
      
      
      expect(page).to have_content("Link to discount page: Discount id# #{@disc2.id}")
      expect(page).to have_content("Quantity Threshold: #{@disc2.quantity}")
      expect(page).to have_content("Percentage Discount: #{@disc2.percentage}")

      click_link "Discount id# #{@disc2.id}"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/#{@disc2.id}")
    end
  end
end