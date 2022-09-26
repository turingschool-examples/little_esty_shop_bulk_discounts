require "rails_helper"


RSpec.describe("bulk discount edit") do
  before(:each) do
    @merchant1 = Merchant.create!(    name: "Hair Care")
    @discount1 = BulkDiscount.create!(    percentage_discount: 20,     quantity_threshold: 10,     merchant_id: @merchant1.id)
  end

  it("I am taken to a new page with a form to edit the discount") do
    visit(merchant_bulk_discount_path(@merchant1.id, @discount1.id))
    click_on("Edit Discount ##{@discount1.id}")
    expect(current_path).to(eq(edit_merchant_bulk_discount_path(@merchant1.id, @discount1.id)))
  end

  it("I see that the discounts current attributes are pre-poluated in the form") do
    visit((edit_merchant_bulk_discount_path(@merchant1.id, @discount1.id)))
    save_and_open_page
    expect(page).to(have_content("Edit discount page"))
    expect(page).to(have_field("percentage_discount",     with: 20))
    expect(page).to(have_field("quantity_threshold",     with: 10))
  end

  it("I change any/all of the information and click submit
Then I am redirected to the bulk discount's show page") do
    visit((edit_merchant_bulk_discount_path(@merchant1.id, @discount1.id)))
    fill_in("percentage_discount",     with: 7)
    fill_in("quantity_threshold",     with: 17)
    click_on("Submit")
    expect(current_path).to(eq(merchant_bulk_discount_path(@merchant1.id, @discount1.id)))
  end

  it("i see that the discount's attributes have been updated") do
    visit(merchant_bulk_discount_path(@merchant1.id, @discount1.id))
    visit((edit_merchant_bulk_discount_path(@merchant1.id, @discount1.id)))
    fill_in("percentage_discount",     with: 7)
    fill_in("quantity_threshold",     with: 17)
    click_on("Submit")
    expect(current_path).to(eq(merchant_bulk_discount_path(@merchant1.id, @discount1.id)))
    expect(page).to(have_content("Percentage Discount:7%"))
    expect(page).to(have_content("Quantity Threshold:17"))
  end
end
