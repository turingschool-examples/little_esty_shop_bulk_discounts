require 'rails_helper'

RSpec.describe 'Bulk Discounts Edit Page and Form' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Hair Care')

    @bd1 = @merchant1.bulk_discounts.create!(threshold: 10, discount: 10)
    @bd2 = @merchant1.bulk_discounts.create!(threshold: 15, discount: 15)
    @bd3 = @merchant1.bulk_discounts.create!(threshold: 20, discount: 20)
  end

  context 'when I visit the bulk discounts show page' do
    describe 'and I click on the button to edit the discount information' do
      it 'has a link to edit that bulk discounts information' do
        visit "/merchant/#{@merchant1.id}/bulk_discounts/#{@bd1.id}"
        click_link "Edit Discount ##{@bd1.id}"

        expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/#{@bd1.id}/edit")

        fill_in :discount, with: 13
        fill_in :threshold, with: 13
        click_button "Submit"

        expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/#{@bd1.id}")

        expect(page).to have_content("Discount: 13%")
        expect(page).to have_content("Threshold: 13 Items")

        expect(page).to_not have_content("Discount: 10%")
        expect(page).to_not have_content("Threshold: 10 Items")
      end

      it 'has fields which are pre-filled with the existing discount info' do
        visit "/merchant/#{@merchant1.id}/bulk_discounts/#{@bd1.id}"

        click_link "Edit Discount ##{@bd1.id}"

        expect(current_path).to eq("/merchant/#{@merchant1.id}/bulk_discounts/#{@bd1.id}/edit")

        expect(find_field('Discount').value).to eq("10")
        expect(find_field('Threshold').value).to eq("10")
      end

      # EDGE CASE / Extra Testing Scenarios
      it 'will always be up to date after repeated updates' do
        visit "/merchant/#{@merchant1.id}/bulk_discounts/#{@bd1.id}"

        click_link "Edit Discount ##{@bd1.id}"

        expect(find_field('Discount').value).to eq("10")
        expect(find_field('Threshold').value).to eq("10")

        fill_in :discount, with: 13
        fill_in :threshold, with: 13
        click_button "Submit"

        # User has returned to show page
        click_link "Edit Discount ##{@bd1.id}"

        expect(find_field('Discount').value).to eq("13")
        expect(find_field('Threshold').value).to eq("13")

        fill_in :discount, with: 17
        fill_in :threshold, with: 17
        click_button "Submit"

        expect(page).to have_content("Discount: 17%")
        expect(page).to have_content("Threshold: 17 Items")

        expect(page).to_not have_content("Discount: 10%")
        expect(page).to_not have_content("Threshold: 10 Items")

        expect(page).to_not have_content("Discount: 13%")
        expect(page).to_not have_content("Threshold: 13 Items")
      end
      # EDGE CASE
      it 'allows the user to only change one attribute' do
        visit "/merchant/#{@merchant1.id}/bulk_discounts/#{@bd1.id}"

        click_link "Edit Discount ##{@bd1.id}"

        expect(find_field('Discount').value).to eq("10")
        expect(find_field('Threshold').value).to eq("10")

        # Only choosing to update one field
        fill_in :threshold, with: 13
        click_button "Submit"

        expect(page).to have_content("Discount: 10%")
        expect(page).to have_content("Threshold: 13 Items")
      end

      context 'Edge Cases in which the user could break the form' do
        # EDGE CASE
        it 'will return an error message if the user tries to save the form with an empty field' do

        end

        # EDGE CASE
        it 'will return an error message if the user tries to save data that is not an integer' do

        end

        # EDGE CASE
        it 'will return an error message if the user tries to save a percentage higher than 100%' do

        end

        # EDGE CASE
        it 'will return an error message if the user tries to save anything besides a whole number' do

        end

        # EDGE CASE
        it 'will return an error message if the user tries to save a negative number for discount' do

        end

        # EDGE CASE
        it 'will return an error message if the user tries to save a negative number for threshold' do

        end
      end
    end
  end
end
