require "rails_helper"


RSpec.describe("bulk discount show page") do
  before(:each) do
    @merchant1 = Merchant.create!(    name: "Hair Care")
    @discount1 = BulkDiscount.create!(    percentage_discount: 20,     quantity_threshold: 10,     merchant_id: @merchant1.id)
    @discount2 = BulkDiscount.create!(    percentage_discount: 30,     quantity_threshold: 15,     merchant_id: @merchant1.id)
    @discount3 = BulkDiscount.create!(    percentage_discount: 15,     quantity_threshold: 15,     merchant_id: @merchant1.id)
  end

  it("I see the bulk discount's quantity threshold and percentage discount") do
    visit(merchant_bulk_discount_path(@merchant1.id, @discount1.id))
    expect(page).to(have_content("Percentage Discount:#{@discount1.percentage_discount}"))
    expect(page).to(have_content("Quantity Threshold:#{@discount1.quantity_threshold}"))
  end
end
