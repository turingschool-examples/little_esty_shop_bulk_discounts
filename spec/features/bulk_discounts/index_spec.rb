require 'rails_helper'

RSpec.describe "merchant bulk discounts index page" do
  before(:each) do
    @merchant = create(:merchant)
    @bulk_discounts = create_list(:bulk_discount, 5, merchant_id: @merchant.id)
    @bd_1 = @bulk_discounts.first
    @bd_2 = @bulk_discounts[1]
  end
  
  describe "As a merchant, when I visit my bulk discounts index page" do
    it "lists all of my bulk discounts - their discount and their qty threshold" do
      visit merchant_bulk_discounts_path(@merchant.id)
      @bulk_discounts.each do |bd|
        within("#discount-#{bd.id}") do
          expect(page).to have_content("#{bd.percentage_discount}% off #{bd.quantity_threshold} or more")
        end
      end
    end
    