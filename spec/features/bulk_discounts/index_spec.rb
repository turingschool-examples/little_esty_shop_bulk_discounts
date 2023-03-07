require 'rails_helper'

RSpec.describe 'merchant/:merchant_id/bulk_discounts', type: :feature do
  before :each do 
    @merchant1 = Merchant.create!(name: 'The Frisbee Store')

    @bd_basic = @merchant1.bulk_discounts.create!(title: "Basic", percentage_discount: 0.1, quantity_threshold: 2)
    @bd_super = @merchant1.bulk_discounts.create!(title: "Super", percentage_discount: 0.25, quantity_threshold: 4)

    visit merchant_bulk_discounts_path(@merchant1)
  end

  context "as a merchant, when I visit my bulk discounts index page" do
    # User Story 1
    it "I see all my bulk discounts info which includes a link to it's show page" do
      expect(page).to have_content("All Available Bulk Discounts")
      
      within "#bd-#{@bd_basic.id}" do
        expect(page).to have_content("The #{@bd_basic.title}:")
        expect(page).to have_content("10% off #{@bd_basic.quantity_threshold} of the same item")
        expect(page).to have_link("See More", href: "/merchant/#{@merchant1.id}/bulk_discounts/#{@bd_basic.id}")    
      end

      within "#bd-#{@bd_super.id}" do
        expect(page).to have_content("The #{@bd_super.title}:")
        expect(page).to have_content("25% off #{@bd_super.quantity_threshold} of the same item")
        expect(page).to have_link("See More", href: "/merchant/#{@merchant1.id}/bulk_discounts/#{@bd_super.id}")
      end
    end

    # User Story 1
    it "I click that link & am taken to that bulk discount's show page" do
      within "#bd-#{@bd_basic.id}" do
        click_link("See More")
        expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @bd_basic))
      end

      expect(page).to have_content("Details for Bulk Discount: #{@bd_basic.title}")
      expect(page).to have_content("Precentage Discount (as a decimal): #{@bd_basic.percentage_discount}")
      expect(page).to have_content("Quantity Threshold (for same item): #{@bd_basic.quantity_threshold}")
    end

    # User Story 2
    it "I see a link to create a new bulk discount, click it & I'm taken to a bulk discount new page" do 
      expect(page).to have_link("Create New Bulk Discount", href: "/merchant/#{@merchant1.id}/bulk_discounts/new")
    
      click_link("Create New Bulk Discount")

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1.id))
    end

    # User Story 3
    it "I see a link to delete each bulk discount" do
      within "#bd-#{@bd_basic.id}" do
        expect(page).to have_link("Delete", href: "/merchant/#{@merchant1.id}/bulk_discounts/#{@bd_basic.id}")    
      end

      within "#bd-#{@bd_super.id}" do
        expect(page).to have_link("Delete", href: "/merchant/#{@merchant1.id}/bulk_discounts/#{@bd_super.id}")
      end
    end

    # User Story 3
    it "when I click on this link, I'm redirected back to this index page & do NOT see the bulk discount" do
      within "#bd-#{@bd_basic.id}" do
        click_link("Delete")
        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
      end

      expect(page).to_not have_content("The #{@bd_basic.title}:")
      expect(page).to_not have_content("10% off #{@bd_basic.quantity_threshold} of the same item")
      expect(page).to_not have_link("See More", href: "/merchant/#{@merchant1.id}/bulk_discounts/#{@bd_basic.id}")    
    end

    # User Story 9
    it "I see header 'Upcoming Holidays' & name and date of next 3 upcoming US holidays" do
      expect(page).to have_content("Upcoming Holidays")
      
      # How to test this if the holidays change based on WHEN you run this test: 
      expect(page).to have_content("Good Friday - 2023-04-07")
      expect(page).to have_content("Memorial Day - 2023-05-29")
      expect(page).to have_content("Juneteenth - 2023-06-19")

      # is this test needed to be more robust? 
      expect("Good Friday").to appear_before("Memorial Day")
      expect("Memorial Day").to appear_before("Juneteenth")
    end
  end
end