require 'rails_helper' 


RSpec.describe "Merchant Bulk Discount edit" do 
  before :each do
    @merchant1 = Merchant.create!(name: 'Dudes Haberdashery')
    @discount1 = @merchant1.bulk_discounts.create!(percentage_discount: 0.20 ,quantity_threshold: 10)
  end
  #user story 5 
  describe "As a merchant" do 
    describe "When I visit my edit discount form page" do 
      describe "I see that the discounts current attributes are pre-poluated in the form" do 
        describe "When I change any/all of the information and click submit" do
          describe "Then I am redirected to the bulk discount's show page" do 
            it "And I see that the discount's attributes have been updated" do 
              visit edit_merchant_bulk_discount_path(@merchant1, @discount1)
              
              expect(page).to have_field(:percentage_discount, with: '0.2')

              expect(page).to have_field(:quantity_threshold, with: '10')

              fill_in :percentage_discount, with: "0.30" 
              fill_in :quantity_threshold, with: "15"
              click_button "Update Discount"

              expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
              
              expect(page).to have_content("Discount: 30.0%")
              expect(page).to have_content("Quantity Threshold: 15")

            end
            
            it "Validates that the form is created properly before saving " do
              visit edit_merchant_bulk_discount_path(@merchant1, @discount1)
              
              expect(page).to have_field(:percentage_discount, with: '0.2')

              expect(page).to have_field(:quantity_threshold, with: '10')

              fill_in :percentage_discount, with: "" 
              fill_in :quantity_threshold, with: "2"
              click_button "Update Discount"
              expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1))
              expect(page).to have_content("Percentage discount can't be blank")
            end
          end
        end
      end
    end
  end
end