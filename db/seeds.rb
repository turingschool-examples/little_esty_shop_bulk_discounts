Merchant.destroy_all
Customer.destroy_all
Item.destroy_all
BulkDiscount.destroy_all
Invoice.destroy_all
InvoiceItem.destroy_all

# @m1 = Merchant.create!(name: 'Hair Care')
# @m2 = Merchant.create!(name: 'Jewelry')
#
# @c1 = Customer.create!(first_name: 'Bilbo', last_name: 'Baggins')
# @c2 = Customer.create!(first_name: 'Frodo', last_name: 'Baggins')
# @c3 = Customer.create!(first_name: 'Samwise', last_name: 'Gamgee')
# @c4 = Customer.create!(first_name: 'Aragorn', last_name: 'Elessar')
# @c5 = Customer.create!(first_name: 'Arwen', last_name: 'Undomiel')
# @c6 = Customer.create!(first_name: 'Legolas', last_name: 'Greenleaf')
# @item_1 = Item.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10, merchant_id: @m1.id)
# @item_2 = Item.create!(name: 'Conditioner', description: 'This makes your hair shiny', unit_price: 8, merchant_id: @m1.id)
# @item_3 = Item.create!(name: 'Brush', description: 'This takes out tangles', unit_price: 5, merchant_id: @m1.id)
# @i1 = Invoice.create!(customer_id: @c1.id, status: 2)
# @i2 = Invoice.create!(customer_id: @c1.id, status: 2)
# @i3 = Invoice.create!(customer_id: @c2.id, status: 2)
# @i4 = Invoice.create!(customer_id: @c3.id, status: 2)
# @i5 = Invoice.create!(customer_id: @c4.id, status: 2)
# @ii_1 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_1.id, quantity: 13, unit_price: 10, status: 0)
# @ii_2 = InvoiceItem.create!(invoice_id: @i2.id, item_id: @item_2.id, quantity: 25, unit_price: 15, status: 0)
# @ii_3 = InvoiceItem.create!(invoice_id: @i3.id, item_id: @item_3.id, quantity: 7, unit_price: 25, status: 2)
# @ii_4 = InvoiceItem.create!(invoice_id: @i4.id, item_id: @item_3.id, quantity: 2500, unit_price: 20, status: 1)
#
# @bulk_discount1 = BulkDiscount.create!(name: "20% OFF!", percentage: 20, quantity: 4, merchant_id: @m1.id)
# @bulk_discount2 = BulkDiscount.create!(name: "25% OFF!", percentage: 25, quantity: 11, merchant_id: @m1.id)
# @bulk_discount3 = BulkDiscount.create!(name: "30% OFF!", percentage: 30, quantity: 15, merchant_id: @m1.id)
