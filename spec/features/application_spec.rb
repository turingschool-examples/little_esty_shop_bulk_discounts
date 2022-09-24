require 'rails_helper'

RSpec.describe 'Welcome Page' do
  before :each do
    @m1 = Merchant.create!(name: 'Merchant 1')
    @m2 = Merchant.create!(name: 'Merchant 2')
    @m3 = Merchant.create!(name: 'Merchant 3', status: 1)

    @item_1 = Item.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10, merchant_id: @m1.id)
    @item_2 = Item.create!(name: 'Conditioner', description: 'This makes your hair shiny', unit_price: 8, merchant_id: @m2.id)
    @item_3 = Item.create!(name: 'Brush', description: 'This takes out tangles', unit_price: 5, merchant_id: @m3.id)
  end

  it 'Shows the Welcome Page' do
    visit '/'
    save_and_open_page

    expect(page.current_path).to eq('/')
    expect(page).to have_content("Little Esty Shop Homepage")
  end

  it 'and has links to merchants and admin access' do
    visit '/'

    expect(page).to have_link("Merchants Index")

    # click_link('Merchants Index')
    #
    # expect(current_path).to eq('/merchants')
    # expect(page).to have_link('Merchant 1')

    visit '/'

    expect(page).to have_link("Admin Access")

    click_link('Admin Access')
    expect(current_path).to eq('/admin/dashboard')
    expect(current_path).to_not eq('/merchants')
  end
end
