Merchant.destroy_all
Customer.destroy_all
BulkDiscount.destroy_all
Invoice.destroy_all
Item.destroy_all
Transaction.destroy_all
InvoiceItem.destroy_all
merchant1 = Merchant.create!(name: 'Hair Care')

item_1 = Item.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10, merchant_id: merchant1.id,
                      status: 1)
item_2 = Item.create!(name: 'Conditioner', description: 'This makes your hair shiny', unit_price: 8,
                      merchant_id: merchant1.id)

customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: '2012-03-27 14:54:09')
ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 10, unit_price: 10, status: 2)
ii_2 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 5, unit_price: 10, status: 2)

bulk_1 = merchant1.bulk_discounts.create!(percent: 10, threshold: 10)
bulk_2 = merchant1.bulk_discounts.create!(percent: 15, threshold: 15)
