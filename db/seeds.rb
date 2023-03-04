@merchant_1 = Merchant.find(1)

@bulk_discount_1 = BulkDiscount.create!(merchant: @merchant_1, quantity_threshold: 5, percentage_discount: 15)
@bulk_discount_2 = BulkDiscount.create!(merchant: @merchant_1, quantity_threshold: 10, percentage_discount: 20)
@bulk_discount_3 = BulkDiscount.create!(merchant: @merchant_1, quantity_threshold: 15, percentage_discount: 30)
