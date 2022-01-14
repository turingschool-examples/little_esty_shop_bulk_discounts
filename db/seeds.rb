BulkDiscount.destroy_all
Transaction.destroy_all
InvoiceItem.destroy_all
Item.destroy_all
Invoice.destroy_all
Customer.destroy_all
Merchant.destroy_all

@merchant1 = Merchant.create!(name: 'Hair Care')
@merchant2 = Merchant.create!(name: 'Shoe Co')
@merchant3 = Merchant.create!(name: 'TV Co')
@merchant4 = Merchant.create!(name: 'Gym Co')
@merchant5 = Merchant.create!(name: 'Car Co')
@merchant6 = Merchant.create!(name: 'Pet Co')
@merchant7 = Merchant.create!(name: 'Light Co')
@merchant8 = Merchant.create!(name: 'Chair Co')
@merchant9 = Merchant.create!(name: 'Tree Co')
@merchant10 = Merchant.create!(name: 'Food Co')

@customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
@customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
@customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
@customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
@customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
@customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Kuhn')

@invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2)
@invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2)
@invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
@invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
@invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
@invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
@invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1)
@invoice_8 = Invoice.create!(customer_id: @customer_6.id, status: 1)

@item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
@item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
@item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
@item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)

@item_5 = Item.create!(name: "Shoe Stuff", description: "Stuff for shoes", unit_price: 15, merchant_id: @merchant2.id)
@item_6 = Item.create!(name: "Laces", description: "To Tie them", unit_price: 6, merchant_id: @merchant2.id)
@item_7 = Item.create!(name: "Socks", description: "Cuz yes", unit_price: 9, merchant_id: @merchant2.id)
@item_8 = Item.create!(name: "De-Smell", description: "Also, cuz yes", unit_price: 8, merchant_id: @merchant2.id)

@item_9 = Item.create!(name: "VCR", description: "Old school movies", unit_price: 45, merchant_id: @merchant3.id)
@item_10 = Item.create!(name: "Tri color AV cable", description: "Old school cable", unit_price: 20, merchant_id: @merchant3.id)
@item_11 = Item.create!(name: "Antenna", description: "Catch the airwaves", unit_price: 30, merchant_id: @merchant3.id)
@item_12 = Item.create!(name: "Tube Screen", description: "Heavy TV", unit_price: 200, merchant_id: @merchant3.id)

@item_13 = Item.create!(name: "Weights", description: "Lift these", unit_price: 10, merchant_id: @merchant4.id)
@item_14 = Item.create!(name: "Trainors", description: "Get help from these", unit_price: 8, merchant_id: @merchant4.id)
@item_15 = Item.create!(name: "Treadmills", description: "Run on these", unit_price: 5, merchant_id: @merchant4.id)
@item_16 = Item.create!(name: "Protein", description: "Consume these", unit_price: 1, merchant_id: @merchant4.id)

@item_17 = Item.create!(name: "Engine", description: "Turn this on", unit_price: 10, merchant_id: @merchant5.id)
@item_18 = Item.create!(name: "Tire", description: "Get four of these", unit_price: 8, merchant_id: @merchant5.id)
@item_19 = Item.create!(name: "Window", description: "Roll these up and down", unit_price: 5, merchant_id: @merchant5.id)
@item_20 = Item.create!(name: "Steering wheel", description: "Steer with these", unit_price: 1, merchant_id: @merchant5.id)

@item_21 = Item.create!(name: "Dog Shampoo", description: "This washes your dog's hair", unit_price: 15, merchant_id: @merchant6.id)
@item_22 = Item.create!(name: "Dog Conditioner", description: "This makes your dog's hair shiny", unit_price: 12, merchant_id: @merchant6.id)
@item_23 = Item.create!(name: "Dog Brush", description: "This takes out your dogs tangles", unit_price: 8, merchant_id: @merchant6.id)
@item_24 = Item.create!(name: "Dog Hair tie", description: "This holds up your dogs hair", unit_price: 4, merchant_id: @merchant6.id)

@item_25 = Item.create!(name: "Lightbulb", description: "Brighten the room", unit_price: 2, merchant_id: @merchant7.id)
@item_26 = Item.create!(name: "Christmas Lights", description: "Get festive with these", unit_price: 5, merchant_id: @merchant7.id)
@item_27 = Item.create!(name: "Neon Light", description: "Blind everyon with these", unit_price: 10, merchant_id: @merchant7.id)
@item_28 = Item.create!(name: "Hair tie Lights", description: "This holds your light bulbs hair back", unit_price: 1, merchant_id: @merchant7.id)

@item_29 = Item.create!(name: "Chair", description: "Sit down on these", unit_price: 75, merchant_id: @merchant8.id)
@item_30 = Item.create!(name: "Ottoman", description: "Put your feet up", unit_price: 125, merchant_id: @merchant8.id)
@item_31 = Item.create!(name: "Desk Chair", description: "for sitting at a desk", unit_price: 100, merchant_id: @merchant8.id)
@item_32 = Item.create!(name: "Recliner", description: "This holds up your hair", unit_price: 150, merchant_id: @merchant8.id)

@item_33 = Item.create!(name: "Christmas Tree", description: "This washes your hair", unit_price: 10, merchant_id: @merchant9.id)
@item_34 = Item.create!(name: "Aspen Tree", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant9.id)
@item_35 = Item.create!(name: "Cherry Tree", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant9.id)
@item_36 = Item.create!(name: "Apple Tree", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant9.id)

@item_37 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant10.id)
@item_38 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant10.id)
@item_39 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant10.id)
@item_40 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant10.id)

@ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 20, unit_price: 10, status: 0)
@ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 20, unit_price: 8, status: 0)
@ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_3.id, quantity: 10, unit_price: 5, status: 2)
@ii_4 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_4.id, quantity: 10, unit_price: 5, status: 1)
@ii_5 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_5.id, quantity: 15, unit_price: 5, status: 1)
@ii_6 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_6.id, quantity: 1, unit_price: 5, status: 1)
@ii_7 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_7.id, quantity: 1, unit_price: 5, status: 1)
@ii_8 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_8.id, quantity: 1, unit_price: 5, status: 1)
@ii_9 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_9.id, quantity: 1, unit_price: 5, status: 1)
@ii_10 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_10.id, quantity: 1, unit_price: 5, status: 1)
@ii_11 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_11.id, quantity: 1, unit_price: 5, status: 1)
@ii_12 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_12.id, quantity: 1, unit_price: 5, status: 1)
@ii_13 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_13.id, quantity: 1, unit_price: 5, status: 1)
@ii_14 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_14.id, quantity: 1, unit_price: 5, status: 1)
@ii_15 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_15.id, quantity: 1, unit_price: 5, status: 1)
@ii_16 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_16.id, quantity: 1, unit_price: 5, status: 1)
@ii_17 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_17.id, quantity: 1, unit_price: 5, status: 1)
@ii_18 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_18.id, quantity: 1, unit_price: 5, status: 1)
@ii_19 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_19.id, quantity: 1, unit_price: 5, status: 1)
@ii_20 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_20.id, quantity: 1, unit_price: 5, status: 1)
@ii_21 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_21.id, quantity: 1, unit_price: 5, status: 1)
@ii_22 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_22.id, quantity: 1, unit_price: 5, status: 1)
@ii_23 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_23.id, quantity: 1, unit_price: 5, status: 1)
@ii_24 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_24.id, quantity: 1, unit_price: 5, status: 1)
@ii_25 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_25.id, quantity: 1, unit_price: 5, status: 1)
@ii_26 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_26.id, quantity: 1, unit_price: 5, status: 1)
@ii_27 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_27.id, quantity: 1, unit_price: 5, status: 1)
@ii_28 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_28.id, quantity: 1, unit_price: 5, status: 1)
@ii_29 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_29.id, quantity: 1, unit_price: 5, status: 1)
@ii_30 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_30.id, quantity: 1, unit_price: 5, status: 1)
@ii_31 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_31.id, quantity: 1, unit_price: 5, status: 1)
@ii_32 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_32.id, quantity: 1, unit_price: 5, status: 1)
@ii_33 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_33.id, quantity: 1, unit_price: 5, status: 1)
@ii_34 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_34.id, quantity: 1, unit_price: 5, status: 1)
@ii_35 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_35.id, quantity: 1, unit_price: 5, status: 1)
@ii_36 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_36.id, quantity: 1, unit_price: 5, status: 1)
@ii_37 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_37.id, quantity: 1, unit_price: 5, status: 1)
@ii_38 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_38.id, quantity: 1, unit_price: 5, status: 1)
@ii_39 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_39.id, quantity: 1, unit_price: 5, status: 1)
@ii_40 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_40.id, quantity: 1, unit_price: 5, status: 1)


@transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
@transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_3.id)
@transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_4.id)
@transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_5.id)
@transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_6.id)
@transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_7.id)
@transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_2.id)
@transaction8 = Transaction.create!(credit_card_number: 123456, result: 1, invoice_id: @invoice_8.id)

@bd1 = @merchant1.bulk_discounts.create!(threshold: 10, discount: 10)
@bd2 = @merchant1.bulk_discounts.create!(threshold: 15, discount: 15)
@bd3 = @merchant1.bulk_discounts.create!(threshold: 20, discount: 20)

@bd4 = @merchant2.bulk_discounts.create!(threshold: 5, discount: 5)

@bd5 = @merchant3.bulk_discounts.create!(threshold: 10, discount: 11)

@bd6 = @merchant4.bulk_discounts.create!(threshold: 20, discount: 20)
@bd7 = @merchant4.bulk_discounts.create!(threshold: 20, discount: 20)

@bd8 = @merchant5.bulk_discounts.create!(threshold: 10, discount: 10)
@bd9 = @merchant5.bulk_discounts.create!(threshold: 15, discount: 15)

@bd10 = @merchant6.bulk_discounts.create!(threshold: 20, discount: 20)
@bd11 = @merchant6.bulk_discounts.create!(threshold: 20, discount: 20)

@bd12 = @merchant7.bulk_discounts.create!(threshold: 20, discount: 20)
