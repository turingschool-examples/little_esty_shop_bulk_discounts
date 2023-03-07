require 'rails_helper'

RSpec.describe 'bulk_discount index' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @merchant2 = Merchant.create!(name: 'Jewelry')
  
    @bulk_discount1 = @merchant1.bulk_discounts.create!(percentage: 10, threshold: 15)
    @bulk_discount2 = @merchant1.bulk_discounts.create!(percentage: 15, threshold: 25)
    @bulk_discount3 = @merchant1.bulk_discounts.create!(percentage: 25, threshold: 30)
    @bulk_discount4 = @merchant2.bulk_discounts.create!(percentage: 50, threshold: 2)
  end 

  it 'shows all bulk discounts with percentages and thresholds' do
    visit merchant_bulk_discounts_path(@merchant1)

    within "#merchants-discounts-index" do
      expect(page).to have_content("Percentage: #{@bulk_discount1.percentage}")
      expect(page).to have_content("Threshold: #{@bulk_discount1.threshold}")
      expect(page).to have_content("Percentage: #{@bulk_discount2.percentage}")
      expect(page).to have_content("Threshold: #{@bulk_discount2.threshold}")
      expect(page).to have_content("Percentage: #{@bulk_discount3.percentage}")
      expect(page).to have_content("Threshold: #{@bulk_discount3.threshold}")
      expect(page).to_not have_content("Percentage: #{@bulk_discount4.percentage}")
    end
  end

  it 'each bulk discount has a link to its show page' do
    visit merchant_bulk_discounts_path(@merchant1)

    expect(page).to have_link("#{@bulk_discount1.percentage}")
    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
  end

  it 'has a link to create a new bulk discount' do
    visit merchant_bulk_discounts_path(@merchant1)

    expect(page).to have_link("Create New Bulk Discount")

    click_link "Create New Bulk Discount"
    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
  end

  it 'has a button to delete each bulk discount' do
    visit merchant_bulk_discounts_path(@merchant1)
    
    within "#merchants-discounts-index" do
      expect(page).to have_button("Delete Discount")
    end
    within "#discount-#{@bulk_discount1.id}" do
      click_button "Delete Discount"
    end
    
    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    expect(page).to_not have_content(@bulk_discount1.percentage)
    expect(page).to have_content(@bulk_discount2.percentage)
  end
  
  it 'has a section with a header of Upcoming Holidays' do
    visit merchant_bulk_discounts_path(@merchant1)

    expect(page).to have_content("Upcoming Holidays")
  end

  it "has the name and date of the next 3 upcoming US holidays" do
    visit merchant_bulk_discounts_path(@merchant1)
    
    expect("Good Friday 2023-04-07").to appear_before("Memorial Day 2023-05-29")
    expect("Memorial Day 2023-05-29").to appear_before("Juneteenth 2023-06-19")
  end
end
      