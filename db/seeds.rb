@merchant1 = Merchant.find(1)

@discount1 = BulkDiscount.create(merchant_id: @merchant1.id, percentage_discount: 0.05, quantity_threshold: 1, promo_name: "Welcome" )
@discount2 = BulkDiscount.create(merchant_id: @merchant1.id, percentage_discount: 0.1, quantity_threshold: 5, promo_name: "Best of the Net" )
@discount3 = BulkDiscount.create(merchant_id: @merchant1.id, percentage_discount: 0.15, quantity_threshold: 10, promo_name: "Freaky 15" )
@discount3 = BulkDiscount.create(merchant_id: @merchant1.id, percentage_discount: 0.2, quantity_threshold: 15, promo_name: "Blowup" )
@discount3 = BulkDiscount.create(merchant_id: @merchant1.id, percentage_discount: 0.25, quantity_threshold: 20, promo_name: "Loyalty" )
@discount3 = BulkDiscount.create(merchant_id: @merchant1.id, percentage_discount: 0.30, quantity_threshold: 25, promo_name: "Holiday Sale" )