require 'rails_helper' 

RSpec.describe 'merchant discounts index' do 
  before :each do 
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @disc1 = Discount.create!(merchant_id: @merchant1.id, quantity: 10, percentage: 10)
    @disc2 = Discount.create!(merchant_id: @merchant1.id, quantity: 20, percentage: 20)
    
    # @holiday1 = HolidayService.get_dates[0]
    # @holiday2 = HolidayService.get_dates[1]
    # @holiday3 = HolidayService.get_dates[2]

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
      expect(page).to have_button("Delete This Discount")
      
      click_link "Discount id# #{@disc1.id}"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/#{@disc1.id}")
    end

    visit "/merchant/#{@merchant1.id}/discounts"

    within("#discount-#{@disc2.id}") do 
      expect(page).to have_content("Link to discount page: Discount id# #{@disc2.id}")
      expect(page).to have_content("Quantity Threshold: #{@disc2.quantity}")
      expect(page).to have_content("Percentage Discount: #{@disc2.percentage}")
      expect(page).to have_button("Delete This Discount")

      click_link "Discount id# #{@disc2.id}"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/#{@disc2.id}")
    end
  end

  it "should have a link to create a new discount" do 
    within("#create-discount") do 
      expect(page).to have_content("Create New Discount")

      click_link "Create New Discount" 

      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/new")
    end
  end

  it "should have a button to delete a discont" do 
    within("#discount-#{@disc1.id}") do 
      expect(page).to have_content("Link to discount page: Discount id# #{@disc1.id}")
      expect(page).to have_content("Quantity Threshold: #{@disc1.quantity}")
      expect(page).to have_content("Percentage Discount: #{@disc1.percentage}")
      expect(page).to have_button("Delete This Discount")
      
      click_button "Delete This Discount"
    end
      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts")

      expect(page).not_to have_content("Link to discount page: Discount id# #{@disc1.id}")
      expect(page).not_to have_content("Quantity Threshold: #{@disc1.quantity}")
      expect(page).not_to have_content("Percentage Discount: #{@disc1.percentage}")
      
  end

  xit "shows the next three upcoming holidays" do 
    expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts")

    within("#holiday-#{@holiday1.date}") do 
      expect(page).to have_content("Holiday Name: #{@holiday1.name}")
      expect(page).to have_content("Holiday Date: #{@holiday1.date}")
    end

    within("#holiday-#{@holiday2.date}") do 
      expect(page).to have_content("Holiday Name: #{@holiday2.name}")
      expect(page).to have_content("Holiday Date: #{@holiday2.date}")
    end

    within("#holiday-#{@holiday3.date}") do 
      expect(page).to have_content("Holiday Name: #{@holiday3.name}")
      expect(page).to have_content("Holiday Date: #{@holiday3.date}")
    end
  end

end