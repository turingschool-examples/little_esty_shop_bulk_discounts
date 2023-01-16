require 'rails_helper'

RSpec.describe 'new merchants bulk discount form' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    visit new_merchant_bulk_discount_path(@merchant1)
  end
  # 2: Merchant Bulk Discount Create

  # As a merchant
  # When I visit my bulk discounts index
  # Then I see a link to create a new discount
  # When I click this link
  # Then I am taken to a new page where I see a form to add a new bulk discount
  # When I fill in the form with valid data
  # Then I am redirected back to the bulk discount index
  # And I see my new bulk discount listed
  it 'has form fields for a new bulk discount' do
    expect(page).to have_field('Percentage Discount:')
    expect(page).to have_field('Quantity Threshold:')
    expect(page).to have_button('Create New Bulk Discount')
  end

  it 'redirects to bulk discount index when fields are filled with valid data' do
    fill_in('Percentage Discount:', with: 50)
    fill_in('Quantity Threshold:', with: 100)
    click_button('Create New Bulk Discount')

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    
    new_bulk_discount = @merchant1.bulk_discounts.last

    within "#bulk-discount-#{new_bulk_discount.id}" do
      expect(page).to have_content("Bulk Discount #{new_bulk_discount.id}")
      expect(page).to have_content("Percentage Discount: 50%")
      expect(page).to have_content("Quantity Threshold: 100")
    end
  end

  describe "stays on new form page if any fields are invalid" do
    it 'shows too low and too high percentage discount' do
      fill_in('Percentage Discount:', with: -1)
      fill_in('Quantity Threshold:', with: 100)
      click_button('Create New Bulk Discount')

      expect(page).to have_content("New Bulk Discount Creation Failed!")
      expect(page).to have_field('Percentage Discount:', with: -1)
      expect(page).to have_field('Quantity Threshold:', with: 100)
      expect(page).to have_content('Percentage discount must be greater than 0')

      fill_in('Percentage Discount:', with: 120)
      click_button('Create New Bulk Discount')
      
      expect(page).to have_field('Percentage Discount:', with: 120)
      expect(page).to have_field('Quantity Threshold:', with: 100)
      expect(page).to have_content('Percentage discount must be less than 1')

      fill_in('Percentage Discount:', with: 50)
      click_button('Create New Bulk Discount')

      expect(page).to have_content('New Bulk Discount was successfully created')
    end

    it 'shows too low quantity threshold' do
      fill_in('Percentage Discount:', with: 10)
      fill_in('Quantity Threshold:', with: 0)
      click_button('Create New Bulk Discount')

      expect(page).to have_content("New Bulk Discount Creation Failed!")
      expect(page).to have_field('Percentage Discount:', with: 10)
      expect(page).to have_field('Quantity Threshold:', with: 0)
      expect(page).to have_content('Quantity threshold must be greater than 0')

      fill_in('Quantity Threshold:', with: 1)
      click_button('Create New Bulk Discount')

      expect(page).to have_content('New Bulk Discount was successfully created')
    end

    it 'does not allow filling in with non integer values' do
      click_button('Create New Bulk Discount')  
      
      expect(page).to have_content("New Bulk Discount Creation Failed!")
      expect(page).to have_field('Percentage Discount:')
      expect(page).to have_field('Quantity Threshold:')
      expect(page).to have_content("Quantity threshold can't be blank")
      expect(page).to have_content("Percentage discount can't be blank")

      fill_in('Percentage Discount:', with: 1)
      fill_in('Quantity Threshold:', with: 0.5)
      click_button('Create New Bulk Discount')

      expect(page).to have_content('Quantity threshold must be an integer')
    end
  end
end