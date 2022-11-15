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
    expect(page).to(have_content("Percentage Discount:#{@discount1.percentage_discount}%"))
    expect(page).to(have_content("Quantity Threshold:#{@discount1.quantity_threshold}"))
  end

  describe("Bulk Discount Edit") do
    it("I see a link to edit the bulk discount and I click this link") do
      visit(merchant_bulk_discount_path(@merchant1.id, @discount1.id))
      expect(page).to(have_link("Edit Discount ##{@discount1.id}"))
    end

    it("I am taken to a new page with a form to edit the discount
I see that the discounts current attributes are pre-poluated in the form") do
      visit(merchant_bulk_discount_path(@merchant1.id, @discount1.id))
      click_on("Edit Discount ##{@discount1.id}")
      expect(current_path).to(eq(edit_merchant_bulk_discount_path(@merchant1.id, @discount1.id)))
    end

    it("I change any/all of the information and click submit Then I am redirected to the bulk discount's show page") do
      visit((edit_merchant_bulk_discount_path(@merchant1.id, @discount1.id)))
      fill_in("Percentage Discount",       with: 76)
      fill_in("Quantity Threshold",       with: 155)
      click_button("Submit")
      expect(current_path).to(eq(merchant_bulk_discount_path(@merchant1.id, @discount1.id)))
    end
  end
end
