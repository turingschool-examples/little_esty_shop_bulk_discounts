InvoiceItem.destroy_all
BulkDiscount.destroy_all
Item.destroy_all
Transaction.destroy_all
Merchant.destroy_all
Invoice.destroy_all
Customer.destroy_all
merchant_1 = Merchant.create!(name: 'Hair Care')
merchant_2 = Merchant.create!(name: 'Hayleys Comcics')

merchant_1.bulk_discounts.create!(percentage: 10, threshold: 10)
merchant_1.bulk_discounts.create!(percentage: 20, threshold: 20)
merchant_2.bulk_discounts.create!(percentage: 30, threshold: 30)

customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Kuhn')

invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 2)
invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 2)
invoice_3 = Invoice.create!(customer_id: customer_2.id, status: 2)
invoice_4 = Invoice.create!(customer_id: customer_3.id, status: 2)
invoice_5 = Invoice.create!(customer_id: customer_4.id, status: 2)
invoice_6 = Invoice.create!(customer_id: customer_5.id, status: 2)
invoice_7 = Invoice.create!(customer_id: customer_6.id, status: 1)

item_1 = Item.create!(name: 'Shampoo', description: 'This wahes your hair', unit_price: 10,
                      merchant_id: merchant_1.id)
item_2 = Item.create!(name: 'Conditioner', description: 'This makes your hair shiny', unit_price: 20,
                      merchant_id: merchant_1.id)
item_3 = Item.create!(name: 'Brush', description: 'This takes out tangles', unit_price: 30,
                      merchant_id: merchant_1.id)
item_4 = Item.create!(name: 'Hair tie', description: 'This holds up your hair', unit_price: 40,
                      merchant_id: merchant_1.id)

InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 5, unit_price: 10, status: 0)
InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 10, unit_price: 20, status: 0)
InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_3.id, quantity: 20, unit_price: 30, status: 2)
InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_4.id, quantity: 30, unit_price: 40, status: 1)
InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_4.id, quantity: 40, unit_price: 40, status: 1)
InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_4.id, quantity: 15, unit_price: 40, status: 1)
InvoiceItem.create!(invoice_id: invoice_6.id, item_id: item_4.id, quantity: 1, unit_price: 40, status: 1)

Transaction.create!(credit_card_number: 203_942, result: 1, invoice_id: invoice_1.id)
Transaction.create!(credit_card_number: 230_948, result: 1, invoice_id: invoice_3.id)
Transaction.create!(credit_card_number: 234_092, result: 1, invoice_id: invoice_4.id)
Transaction.create!(credit_card_number: 230_429, result: 1, invoice_id: invoice_5.id)
Transaction.create!(credit_card_number: 102_938, result: 1, invoice_id: invoice_6.id)
Transaction.create!(credit_card_number: 879_799, result: 1, invoice_id: invoice_7.id)
Transaction.create!(credit_card_number: 203_942, result: 1, invoice_id: invoice_2.id)
