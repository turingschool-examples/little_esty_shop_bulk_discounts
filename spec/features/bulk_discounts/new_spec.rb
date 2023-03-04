require 'rails_helper'

RSpec.describe "New Bulk Discount Page", type: :feature do
  before do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Dandelion Plants')

    @fifteen = @merchant1.bulk_discounts.create!(percentage_discount: 0.15, quantity_threshold: 15)
    @twenty = @merchant1.bulk_discounts.create!(percentage_discount: 0.20, quantity_threshold: 20)
    @twenty_five = @merchant1.bulk_discounts.create!(percentage_discount: 0.25, quantity_threshold: 30)
    @thirty = @merchant1.bulk_discounts.create!(percentage_discount: 0.30, quantity_threshold: 50)

    @fifty = @merchant2.bulk_discounts.create!(percentage_discount: 0.50, quantity_threshold: 100)

    visit "/merchant/#{@merchant1.id}/bulk_discounts/new"
  end
  
  it 'I see a form to add a new bulk discount' do
    expect(page).to have_field("Percentage Discount")
    expect(page).to have_field("Quantity Threshold")
    expect(page).to have_button("Create Discount")
  end

  describe 'happy path' do
    it 'I fill out the form, click `Submit`, and am redirected to bulk discount index page' do
      fill_in :percentage_discount, with: 0.10
      fill_in :quantity_threshold, with: 10
      click_button "Create Discount"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts")
      expect(page).to have_content("Discount Created Successfully")
    end
  end

  describe 'Sad path: If I enter invalid information, the discount won`t be created' do
    it 'it can`t be blank' do
      fill_in :percentage_discount, with: ""
      fill_in :quantity_threshold, with: 10
      click_button "Create Discount"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/new")
      expect(page).to have_content("Discount not created: Required information missing")
    
      fill_in :percentage_discount, with: 0.10
      fill_in :quantity_threshold, with: ""
      click_button "Create Discount"
  
      expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/new")
      expect(page).to have_content("Discount not created: Required information missing")
    end

    it 'discount must be between 0 and 1, quanitity between 1 and 100000' do
      fill_in :percentage_discount, with: 20
      fill_in :quantity_threshold, with: 10
      click_button "Create Discount"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/new")
      expect(page).to have_content("Discount not created: Required information missing")

      fill_in :percentage_discount, with: 0
      fill_in :quantity_threshold, with: 10
      click_button "Create Discount"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/new")
      expect(page).to have_content("Discount not created: Required information missing")

      fill_in :percentage_discount, with: 0.50
      fill_in :quantity_threshold, with: 0
      click_button "Create Discount"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/new")
      expect(page).to have_content("Discount not created: Required information missing")

      fill_in :percentage_discount, with: 0.50
      fill_in :quantity_threshold, with: 100001
      click_button "Create Discount"

      expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/new")
      expect(page).to have_content("Discount not created: Required information missing")
    end
  end
end