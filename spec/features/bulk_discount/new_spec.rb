require "rails_helper"


RSpec.describe("bulk discount index") do
  before(:each) do
    @merchant1 = Merchant.create!(    name: "Hair Care")
    @discount1 = BulkDiscount.create!(    percentage_discount: 20,     quantity_threshold: 10,     merchant_id: @merchant1.id)
  end

  it("fill in the form with valid data,I am redirected back to the bulk discount index,I see my new bulk discount listed") do
    visit(new_merchant_bulk_discount_path(@merchant1))
    save_and_open_page
    fill_in("Percentage discount",     with: 10)
    fill_in("Quantity threshold",     with: 15)
    click_button("Submit")
    expect(current_path).to(eq((merchant_bulk_discounts_path(@merchant1.id))))
  end
end
