require 'rails_helper' 

RSpec.describe 'New bulk discount page for a merchant' do 
  before :each do 
    @merchant1 = Merchant.create!(name: 'Hair Care')

    visit "/merchant/#{@merchant1.id}/discounts/new"
  end

  it 'shows the merchant name at the top' do 
    within("#merchant-info") do 
      expect(page).to have_content("#{@merchant1.name} - Create New Discount")
    end
  end

  it 'should be able to generate a discount for a merchant with valid inputs' do 
    within("#discount-form") do 
      fill_in :quantity, with: 10
      fill_in :percentage, with: 10

      click_button
    end

      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts")
        disc = Discount.last
      within("#discount-#{disc.id}") do 
        expect(page).to have_content("Link to discount page: Discount id# #{disc.id}")
        expect(page).to have_content("Quantity Threshold: #{disc.quantity}")
        expect(page).to have_content("Percentage Discount: #{disc.percentage}")
      end
  end

  it 'should NOT be able to generate a discount for a merchant with INVALID inputs' do 
    within("#discount-form") do 
      fill_in :quantity, with: "khoa is pretty"
      fill_in :percentage, with: 10

      click_button
    end
    expect(page).to have_content("Quantity is not a number")
  end
end