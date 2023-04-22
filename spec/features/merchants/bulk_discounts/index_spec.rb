require 'rails_helper'

RSpec.describe 'dashboard/bulk_discounts index spec'do
  before :each do
    test_data
    visit merchant_bulk_discounts_path(@merchant1)
  end
    
  describe 'As a merchant when I visit my bulk discount index page' do
    it 'I see all of my bulk discounts including their percentage discount and quantity thresholds' do
      within "#bulk_discount_#{@bulk_disc1.id}" do
        expect(page).to have_content(@bulk_disc1.name)
        expect(page).to have_content(@bulk_disc1.discount_percent)
        expect(page).to have_content(@bulk_disc1.quantity_threshold)
        expect(page).to_not have_content(@bulk_disc2.name)
        expect(page).to_not have_content(@bulk_disc2.discount_percent)
        expect(page).to_not have_content(@bulk_disc2.quantity_threshold)
      end
      
      within "#bulk_discount_#{@bulk_disc2.id}" do
        expect(page).to have_content(@bulk_disc2.name)
        expect(page).to have_content(@bulk_disc2.discount_percent)
        expect(page).to have_content(@bulk_disc2.quantity_threshold)
        expect(page).to_not have_content(@bulk_disc1.name)
        expect(page).to_not have_content(@bulk_disc1.discount_percent)
        expect(page).to_not have_content(@bulk_disc1.quantity_threshold)
      end
    end

    it 'each bulk discounts name links to its show page' do 
      within "#bulk_discount_#{@bulk_disc1.id}" do
        expect(page).to have_link "#{@bulk_disc1.name}"
        click_link "#{@bulk_disc1.name}"
        
        expect(current_path).to eq(bulk_discount_path(@bulk_disc1))
      end
      
      visit merchant_bulk_discounts_path(@merchant1)
      
      within "#bulk_discount_#{@bulk_disc2.id}" do
        expect(page).to have_link "#{@bulk_disc2.name}"
        
        click_link "#{@bulk_disc2.name}"
        
        expect(current_path).to eq(bulk_discount_path(@bulk_disc2))
      end
    end
    
    it 'I see a link to create a new discount, 
      when I click this link I am taken to a new page ' do
      expect(page).to have_link "Create a new Bulk Discount"

      click_link "Create a new Bulk Discount"

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
    end
  end
end