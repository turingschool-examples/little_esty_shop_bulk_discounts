@merchant1 = Merchant.create!(name: 'Hair Care')
@item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
@item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)

@customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
@invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
@ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
@ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 12, unit_price: 6, status: 1)

@bd_basic = @merchant1.bulk_discounts.create!(title: "Basic", percentage_discount: 0.1, quantity_threshold: 5)
@bd_super = @merchant1.bulk_discounts.create!(title: "Super", percentage_discount: 0.25, quantity_threshold: 10)
@bd_seasonal = @merchant1.bulk_discounts.create!(title: "Seasonal", percentage_discount: 0.2, quantity_threshold: 5)  

