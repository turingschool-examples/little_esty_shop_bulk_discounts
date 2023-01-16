require 'rails_helper'
# 5: Merchant Bulk Discount Edit

# As a merchant
# When I visit my bulk discount show page
# Then I see a link to edit the bulk discount
# When I click this link
# Then I am taken to a new page with a form to edit the discount
# And I see that the discounts current attributes are pre-poluated in the form
# When I change any/all of the information and click submit
# Then I am redirected to the bulk discount's show page
# And I see that the discount's attributes have been updated

RSpec.describe 'merchant bulk discount edit form' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Sallie Mae')
    @discount1a = @merchant1.bulk_discounts.create!(percentage_discount: 0.20, quantity_threshold: 10)
    visit edit_merchant_bulk_discount_path(@merchant1, @discount1a)
  end
  it 'prepopulates fields with discounts attributes' do
    expect(page).to have_field('Percentage Discount:', with: '20')
    expect(page).to have_field('Quantity Threshold:', with: '10')
    expect(page).to have_button('Update Existing Bulk Discount')
  end

  it 'redirects to bulk discounts show page with any updated attribtues if changed with valid fields' do
    fill_in('Percentage Discount:', with: 50)
    fill_in('Quantity Threshold:', with: 100)
    click_button('Update Existing Bulk Discount')

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1a))

    expect(page).to have_content("#{@merchant1.name}'s Bulk Discount-#{@discount1a.id} Show Page")
    expect(page).to have_content("Percentage Discount: 50%")
    expect(page).to have_content("Quantity Threshold: 100")
  end

  describe "stays on edit form page if any fields are invalid" do
    it 'shows too low and too high percentage discount' do
      fill_in('Percentage Discount:', with: -1)
      fill_in('Quantity Threshold:', with: 100)
      click_button('Update Existing Bulk Discount')

      expect(page).to have_content("Existing Bulk Discount Update Failed!")
      expect(page).to have_field('Percentage Discount:', with: -1)
      expect(page).to have_field('Quantity Threshold:', with: 100)
      expect(page).to have_content('Percentage discount must be greater than 0')

      fill_in('Percentage Discount:', with: 120)
      click_button('Update Existing Bulk Discount')
      
      expect(page).to have_field('Percentage Discount:', with: 120)
      expect(page).to have_field('Quantity Threshold:', with: 100)
      expect(page).to have_content('Percentage discount must be less than 1')

      fill_in('Percentage Discount:', with: 50)
      click_button('Update Existing Bulk Discount')

      expect(page).to have_content('Existing Bulk Discount was successfully updated!')
    end

    it 'shows too low quantity threshold' do
      fill_in('Percentage Discount:', with: 10)
      fill_in('Quantity Threshold:', with: 0)
      click_button('Update Existing Bulk Discount')

      expect(page).to have_content("Existing Bulk Discount Update Failed!")
      expect(page).to have_field('Percentage Discount:', with: 10)
      expect(page).to have_field('Quantity Threshold:', with: 0)
      expect(page).to have_content('Quantity threshold must be greater than 0')

      fill_in('Quantity Threshold:', with: 1)
      click_button('Update Existing Bulk Discount')

      expect(page).to have_content('Existing Bulk Discount was successfully updated!')
    end

    it 'does not allow filling in with non integer values' do
      fill_in('Percentage Discount:', with: "")
      fill_in('Quantity Threshold:', with: "")
      click_button('Update Existing Bulk Discount')  
      
      expect(page).to have_content("Existing Bulk Discount Update Failed!")
      expect(page).to have_field('Percentage Discount:')
      expect(page).to have_field('Quantity Threshold:')
      expect(page).to have_content("Quantity threshold can't be blank")
      expect(page).to have_content("Percentage discount can't be blank")

      fill_in('Percentage Discount:', with: 1)
      fill_in('Quantity Threshold:', with: 0.5)
      click_button('Update Existing Bulk Discount')

      expect(page).to have_content('Quantity threshold must be an integer')
    end
  end
end