@merchant1 = Merchant.find(1)

@customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')

@item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
@item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)

@invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")

@ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 5, unit_price: 10, status: 2)
@ii_13 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 10, unit_price: 15, status: 2)

@discount1 = BulkDiscount.create(merchant_id: @merchant1.id, percentage_discount: 0.1, quantity_threshold: 10, promo_name: "Welcome" )
@discount2 = BulkDiscount.create(merchant_id: @merchant1.id, percentage_discount: 0.05, quantity_threshold: 15, promo_name: "Thank You" )
@discount3 = BulkDiscount.create(merchant_id: @merchant1.id, percentage_discount: 0.15, quantity_threshold: 5, promo_name: "Nice" )