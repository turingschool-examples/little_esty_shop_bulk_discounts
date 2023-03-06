require 'rails_helper' 


RSpec.describe "Merchant Bulk Discount New" do 
  before :each do
    @merchant1 = Merchant.create!(name: 'Dudes Haberdashery')
  end
  #user story 2 
  describe "As a merchant" do 
    describe " When I click the new discount button" do 
      describe " Then I am taken to a new page where I see a form to add a new bulk discount" do 
        describe " When I fill in the form with valid data " do
          describe " Then I am redirected back to the bulk discount index " do 
            it " And I see my new bulk discount listed " do 
              visit merchant_bulk_discounts_path(@merchant1)
              expect(page). to have_button("New Discount")
              click_button("New Discount")
              expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))

              expect(page).to have_field(:percentage_discount)
              expect(page).to have_field(:quantity_threshold)

              fill_in :percentage_discount, with: 0.30 
              fill_in :quantity_threshold, with: 15
              click_button("Add Discount")
              
              expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
              
              within("#discounts-#{@merchant1.bulk_discounts.last.id}") do
                expect(page).to have_content("Discount: 30.0%")
                expect(page).to have_content("Quantity Threshold: 15")
              end 
            end
            it " Validates that the form is created properly before saving" do
              visit merchant_bulk_discounts_path(@merchant1)
              expect(page). to have_button("New Discount")
              click_button("New Discount")
              expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))

              expect(page).to have_field(:percentage_discount)
              expect(page).to have_field(:quantity_threshold)

              fill_in :percentage_discount, with: ""
              fill_in :quantity_threshold, with: 15
              click_button("Add Discount")
              expect(page).to have_content("Percentage discount can't be blank")
            end
          end
        end
      end
    end
  end
end